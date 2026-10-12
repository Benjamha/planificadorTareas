#include <iostream>

using namespace std;

int main()
{
    string username;
    string password;
    cout << "LOGIN" << endl;
    bool band = false;
    int i = 0;
    while (band == false)
    {
        cout << "Usuario: ";
        cin >> username;
        cout << "Clave: ";
        cin >> password;
        if (username == "benjamha" and password == "1525")
        {
            cout << "INICIO DE SESION CORRECTO";
            band = true;
        }
        else
        {
            cout << "Usuario/Clave incorrecto/s" << endl;
            i++;
        }

        if (i == 3)
        {
            cout << "Limite de intentos alcanzados" << endl;
            abort();
        }
    }
}