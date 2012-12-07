CXX = g++-4.5.4

CXXFLAGS = -std=c++0x -O3 -Wall -g -mavx
LDFLAGS = -lpapi

dot-product: main.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o dot-product main.cpp
