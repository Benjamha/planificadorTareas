#include <iostream>

using namespace std;

void login(string u, string p)
{
    bool band = false;
    int i = 0;
    while (band == false)
    {
        cout << "Usuario: ";
        cin >> u;
        cout << "Clave: ";
        cin >> p;
        if (u == "benjamha" and p == "1525")
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

int main()
{
    string username;
    string password;
    cout << "LOGIN" << endl;
    login(username, password);
    return 0;
}