#include <iostream>
#include <cassert>
#include <iomanip>

#include <string.h>
#include <malloc.h>
#include <papi.h>

extern "C" {
#include <cblas.h>
}

#include <cublas.h>

using namespace std;

// I stole this number from the ATLAS assembly.
const int PREFETCH_DISTANCE = 80;
//const int PREFETCH_DISTANCE = 32;

const int NUM_TRIALS = 100;

template<typename DotFunction>
float time_dot(DotFunction f, int N, float *A, float *B) {
    auto total = 0;

    for(int i = 0; i < NUM_TRIALS; ++i) {
        auto start = PAPI_get_real_usec();

        auto dot = f(N, A, B);

        auto stop = PAPI_get_real_usec();

        // A relatively harmless call to keep the compiler from realizing
        // we don't actually do any useful work with the dot product.
        srand48(dot);
        
        total += stop - start;
    }

    return float(total) / (1e6 * NUM_TRIALS);
}

// Generate a random vector
float *generate_vector(int N) {
    float *v = (float *)memalign(32,
                                 sizeof(float) * N);

    for(int i = 0; i < N; ++i) {
        v[i] = drand48();
    }

    return v;
}

float simple_dot(int, float *, float *);
float simple_prefetch_dot(int, float *, float *);
float unroll_dot(int, float *, float *);
float sse_dot(int, float *, float *);
float avx_dot(int, float *, float *);
float avx_unroll_dot(int, float *, float *);
float avx_unroll_prefetch_dot(int, float *, float *);
float blas_dot(int, float *, float *);
float cublas_dot(int, float *, float *);

int main() {
    auto N = (128 << 20) / sizeof(float);

    cout << "Generating " << N << " element vectors." << endl;

    auto A = generate_vector(N);
    auto B = generate_vector(N);

    assert(A);
    assert(B);
    
#define TIME(f) cout << setw(24) << #f "\t" << time_dot(f, N, A, B) << endl;
    
    TIME(simple_dot);
    TIME(simple_prefetch_dot);
    TIME(unroll_dot);
    TIME(sse_dot);
    TIME(avx_dot);
    TIME(avx_unroll_dot);
    TIME(avx_unroll_prefetch_dot);
    TIME(blas_dot);

    cublasInit();
    TIME(cublas_dot);


    cublasShutdown();
    free(A);
    free(B);
}

// Returns the time in seconds to compute the dot product.
//
// This is the usual implementation.
float simple_dot(int N, float *A, float *B) {
    float dot = 0;
    for(int i = 0; i < N; ++i) {
        dot += A[i] * B[i];
    }

    return dot;
}

float unroll_dot(int N, float *A, float *B) {
    float dot1 = 0, dot2 = 0, dot3 = 0, dot4 = 0;

    for(int i = 0; i < N; i += 4) {
        dot1 += A[i] * B[i];
        dot2 += A[i + 1] * B[i + 1];
        dot3 += A[i + 2] * B[i + 2];
        dot4 += A[i + 3] * B[i + 3];
    }

    return dot1 + dot2 + dot3 + dot4;
}

float simple_prefetch_dot(int N, float *A, float *B) {
    float dot = 0;
    for(int i = 0; i < N; ++i) {
        __builtin_prefetch(A + i + PREFETCH_DISTANCE, 0, 0);
        dot += A[i] * B[i];
    }

    return dot;
}

float sse_dot(int N, float *A, float *B) {
    const int VECTOR_SIZE = 4;

    typedef float vec
        __attribute__ ((vector_size (sizeof(float) * VECTOR_SIZE)));

    vec temp = {0};

    N /= VECTOR_SIZE;

    vec *Av = (vec *)A;
    vec *Bv = (vec *)B;

    for(int i = 0; i < N; ++i) {
        temp += *Av * *Bv;

        Av++;
        Bv++;
    }

    union {
        vec tempv;
        float tempf[VECTOR_SIZE];
    };

    tempv = temp;

    float dot = 0;
    for(int i = 0; i < VECTOR_SIZE; ++i) {
        dot += tempf[i];
    }

    return dot;
}

float avx_dot(int N, float *A, float *B) {
    const int VECTOR_SIZE = 8;

    typedef float vec
        __attribute__ ((vector_size (sizeof(float) * VECTOR_SIZE)));

    vec temp = {0};

    N /= VECTOR_SIZE;

    vec *Av = (vec *)A;
    vec *Bv = (vec *)B;

    for(int i = 0; i < N; ++i) {
        temp += *Av * *Bv;

        Av++;
        Bv++;
    }

    union {
        vec tempv;
        float tempf[VECTOR_SIZE];
    };

    tempv = temp;

    float dot = 0;
    for(int i = 0; i < VECTOR_SIZE; ++i) {
        dot += tempf[i];
    }

    return dot;
}

float avx_unroll_dot(int N, float *A, float *B) {
    const int VECTOR_SIZE = 8;

    typedef float vec
        __attribute__ ((vector_size (sizeof(float) * VECTOR_SIZE)));

    vec temp1 = {0}, temp2 = {0};

    N /= VECTOR_SIZE * 2;

    vec *Av = (vec *)A;
    vec *Bv = (vec *)B;

    for(int i = 0; i < N; ++i) {
        temp1 += *Av * *Bv;

        Av++;
        Bv++;

        temp2 += *Av * *Bv;

        Av++;
        Bv++;
    }

    union {
        vec tempv;
        float tempf[VECTOR_SIZE];
    };

    tempv = temp1;

    float dot = 0;
    for(int i = 0; i < VECTOR_SIZE; ++i) {
        dot += tempf[i];
    }

    tempv = temp2;

    for(int i = 0; i < VECTOR_SIZE; ++i) {
        dot += tempf[i];
    }

    return dot;
}

float avx_unroll_prefetch_dot(int N, float *A, float *B) {
    const int VECTOR_SIZE = 8;

    typedef float vec
        __attribute__ ((vector_size (sizeof(float) * VECTOR_SIZE)));

    vec temp1 = {0}, temp2 = {0};

    N /= VECTOR_SIZE * 2;

    vec *Av = (vec *)A;
    vec *Bv = (vec *)B;

    for(int i = 0; i < N; ++i) {
        __builtin_prefetch(Av + 2, 0, 0);
        temp1 += *Av * *Bv;

        Av++;
        Bv++;

        temp2 += *Av * *Bv;

        Av++;
        Bv++;
    }

    union {
        vec tempv;
        float tempf[VECTOR_SIZE];
    };

    tempv = temp1 + temp2;

    float dot = 0;
    for(int i = 0; i < VECTOR_SIZE; ++i) {
        dot += tempf[i];
    }

    return dot;
}

float blas_dot(int N, float *A, float *B) {
    return cblas_sdot(N, A, 1, B, 1);
}

float cublas_dot(int N, float *A, float *B) {
    float *Ad;
    float *Bd;
    cublasAlloc(N, sizeof(float), (void **)&Ad);
    cublasAlloc(N, sizeof(float), (void **)&Bd);

    cublasSetVector(N, sizeof(float), A, 1, Ad, 1);
    cublasSetVector(N, sizeof(float), B, 1, Bd, 1);

    float dot = cublasSdot(N, Ad, 1, Bd, 1);
    assert(cublasGetError() == CUBLAS_STATUS_SUCCESS);

    cublasFree(Ad);
    cublasFree(Bd);

    return dot;
}
