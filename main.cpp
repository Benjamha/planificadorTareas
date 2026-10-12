#include <iostream>

using namespace std;

void login(string u, string p)
{
    bool band = false;
    int i = 0;
    cout << "LOGIN" << endl;
    while (band == false)
    {
        cout << "Usuario: ";
        cin >> u;
        cout << "Clave: ";
        cin >> p;
        if (u == "benjamha" and p == "1525")
        {
            cout << "INICIO DE SESION CORRECTO" << endl;
            band = true;
        }
        else
        {
            cout << "Usuario/Clave incorrecto/s" << endl;
            i++;
        }

        if (i == 3)
        {
            cout << "Limite de intentos alcanzado" << endl;
            abort();
        }
    }
}

int main()
{
    string username;
    string password;
    login(username, password);
    int op;
    while (true)
    {
        cout << "PLANIFICADOR DE TAREAS" << endl;
        cout << "1. Ver Tareas" << endl;
        cout << "2. Crear Tarea" << endl;
        cout << "3. Eliminar tarea" << endl;
        cout << "4. Modificar Tarea" << endl;
        cout << "5. Salir" << endl;
        cout << "Ingresar opcion: ";
        cin >> op;
        if (op == 5)
        {
            break;
        }
    }

    return 0;
}