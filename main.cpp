#include <iostream>
#include <cassert>

#include <papi.h>

using namespace std;

template<typename DotFunction>
float time_dot(DotFunction f, int N, float *A, float *B) {
    auto start = PAPI_get_real_usec();

    f(N, A, B);

    auto stop = PAPI_get_real_usec();

    return float(stop - start) / 1e6;    
}

// Generate a random vector
float *generate_vector(int N) {
    float *v = new float[N];

    for(int i = 0; i < N; ++i) {
        v[i] = drand48();
    }

    return v;
}

float simple_dot(int, float *, float *);

int main() {
    auto N = (128 << 20) / sizeof(float);

    cout << "Generating " << N << " element vectors." << endl;

    auto A = generate_vector(N);
    auto B = generate_vector(N);

    assert(A);
    assert(B);
    
    cout << "Simple\t" << time_dot(simple_dot, N, A, B) << endl;;
    
    delete [] A;
    delete [] B;
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
