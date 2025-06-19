CXX = clang++
CXXFLAGS = -std=c++17 -Wall -Wextra -g -fno-omit-frame-pointer -fsanitize=address,undefined

SOURCES = src/main.cpp src/ThreadAffinity.cpp
HEADERS = src/*.h
TARGET = app

all:
	$(CXX) $(CXXFLAGS) $(SOURCES) -o $(TARGET)

clean:
	rm -f $(TARGET)
