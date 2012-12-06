ifndef CXX
	CXX = clang++
endif

CXXFLAGS = -std=c++0x -O -Wall -g
LDFLAGS = -lpapi

dot-product: main.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o dot-product main.cpp
