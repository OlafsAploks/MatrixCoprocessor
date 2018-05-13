#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    ofstream output;

    //unsigned char c[5] = {69, 68, 67, 66, 65}; //test case
    short int A[16] =
                 {
                  1,   2,    4,    8,  16,
                  32,  64,   128,  256,
                  512, 1024, 2048, 4096,
                    8192,    16834,   32768
                 };
    short int B[16] =
                  {
                  3,   6,    12,    24,
                  48,  96,   192,  384,
                  768, 1536, 3072, 7,
                  15,   31,    63,   127
                  };
    // 0 => addition, 1 => subtraction, 2 => multiplication, 3 => inversion
    short int operation = 2;

    long pos;
    output.open("file_memory.bin", ios::out | ios::binary | ios::trunc);
    if(output.is_open()) {
        for(int i=0; i<16; i++) {
            output.write(reinterpret_cast<const char *>(&A[i]), sizeof(A[i]));
        }
        output.write(reinterpret_cast<const char *>(&operation), sizeof(operation));
        for(int i=0; i<16; i++) {
            output.write(reinterpret_cast<const char *>(&B[i]), sizeof(B[i]));
        }
    }
    output.close();
    cout << sizeof(A[4]) << endl;
    return 0;
}
