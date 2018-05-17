#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    ofstream writeToFile;
    ifstream readFromFile;

    //-------------------------------!!!!!!!!!!!!!!!!-----------------------------
    //MATRICAS DEFINĒT SAGRIEZTAS (TRANSPONĒTAS) KOLLONA = RINDA un RINDA = KOLONNA
    //unsigned char c[5] = {69, 68, 67, 66, 65}; //test case
    //--------------------------------???????????????-------------------------------
   /* short int A[16] =
                 {
                  A11,   A12,    A13,    A14,
                  A21,   A22,    A23,    A24,
                  A31,   A32,    A33,    A34,
                  A41,   A42,    A43,    A44
                 };
                 */
    //short int A[16] = {256,1024,256,1024, 512,1280,512,256, 768,256,512,512, 256,768,768,768};
    //short int B[16] = {512,2048,1024,256, 1024,1024,256,2048, 256,256,1280,1792, 768,1536,768,512};

    //short int A[16] = {2560,2560,2560,2560, 2560,2560,2560,2560, 2560,2560,2560,2560, 2560,2560,2560,2560};
    short int A[16] = {768,768,768,768, 768,768,768,768, 768,768,768,768, 768,768,768,768};
    /*shor int B[16] = {0b0000100100000000,0000100000000000,0000011100000000,0000011000000000,//9,8,7,6
                      0b0000010100000000,0000010000000000,0000001100000000,0000001000000000,//5,4,3,2
                      0b0000100100000000,0000100000000000,0000011100000000,0000011000000000,//9,8,7,6
                      0b0000010100000000,0000010000000000,0000001100000000,0000001000000000,//5,4,3,2
                      };*/
    short int B[16] = {0b0000100100000000, 0b0000010100000000, 0b0000100100000000, 0b0000010100000000, //9,5,9,5
                      0b0000100000000000, 0b0000010000000000, 0b0000100000000000, 0b0000010000000000, //8,4,8,4
                      0b0000011100000000, 0b0000001100000000, 0b0000011100000000, 0b0000001100000000, //7,3,7,3
                      0b0000011000000000, 0b0000001000000000, 0b0000011000000000, 0b0000001000000000  //6,2,6,2
                      };
    // 0 => addition, 1 => subtraction, 2 => multiplication, 3 => inversion
    short int operation = 1;
    long pos;
    bool validOperation = false;
    string cmd, op;

    bool quit = false;
    while (!quit) {
        cout << " \"wr\" - write, \"r\" - read, \"q\" - quit" << endl;
        cin >> cmd;
        if(cmd == "wr") {
            while(!validOperation) {
                cout << "Enter operation( +/-/*/inv ):" << endl;
                cin >> op;
                if(op == "+") {
                    operation = 0;
                    validOperation = true; break;
                } else if(op == "-") {
                    operation = 1;
                    validOperation = true; break;
                } else if(op == "*") {
                    operation = 2;
                    validOperation = true; break;
                } else if(op == "inv") {
                    operation = 3;
                    validOperation = true; break;
                } else {
                    cout << "Illegal operation" << endl;
                }
            }
            writeToFile.open("file_memory.bin", ios::out | ios::binary | ios::trunc);
            if(writeToFile.is_open()) {
                for(int i=0; i<16; i++) {
                cout << i << " " << A[i] << endl;
                writeToFile.write(reinterpret_cast<const char *>(&A[i]), sizeof(A[i]));
                }
                writeToFile.write(reinterpret_cast<const char *>(&operation), sizeof(operation));
                for(int i=0; i<16; i++) {
                    cout <<  i << " " << B[i] << endl;
                    writeToFile.write(reinterpret_cast<const char *>(&B[i]), sizeof(B[i]));
                }
                validOperation = false;
                writeToFile.close();
            }
        } else if(cmd == "r") {
            readFromFile.open("memory_file.bin", ios::in | ios::binary);
            if(readFromFile.is_open()) {
                readFromFile.seekg (0, readFromFile.end);
                int length = readFromFile.tellg();
                cout << "File length: " << length << endl;
                char * buffer = new char [length];

                readFromFile.seekg(0, readFromFile.beg);
                readFromFile.tellg();
                readFromFile.read(buffer, length);
                signed short int value;
                int br = 0;
                for(int i=0; i<length;) {
                    value = (((int)buffer[i]) << 8) | (int)buffer[i+1];
                    cout << value << " ";
                    i += 2;
                    if(i%8 == 0 && i != 0) { cout << endl;}
                }
                readFromFile.close();
            }
        } else if(cmd == "q") {
            quit = true;
        } else {
            cout << "Unknown command" << endl;
        }
    }
    return 0;
}
