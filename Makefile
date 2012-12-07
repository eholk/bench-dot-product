CXX = g++-4.6.3

CXXFLAGS = -std=c++0x -O3 -Wall -g -mavx
LDFLAGS = -lpapi

dot-product: main.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o dot-product main.cpp
