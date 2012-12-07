CXX = g++-4.6.3

CXXFLAGS = -std=c++0x -O3 -Wall -g -march=corei7-avx -mtune=corei7-avx \
	-I/opt/cuda/include
LDFLAGS = -lpapi -lcblas -L/opt/cuda/lib64 -lcublas

dot-product: main.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o dot-product main.cpp 
