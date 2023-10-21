#include <iostream>

int main() {
    const int numBuffers = 5;
    const int bufferSize = 100;

    int* buffers[numBuffers];
    for (int i = 0; i < numBuffers; i++) {
        buffers[i] = new int[bufferSize];
        for (int j = 0; j < bufferSize; j++) {
            buffers[i][j] = i * j;  
        }
    }

    std::cout << "First value of the third buffer: " << buffers[2][0] << std::endl;

    for (int i = 0; i < numBuffers; i++) {
        delete[] buffers[i];
    }

    return 0;
}
