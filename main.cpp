#include <iostream>
#include <string>
#include <vector>

using namespace std;

bool login()
{
    string u;
    string p;
    cout << "LOGIN" << endl;
    for (int i = 0; i < 3; i++)
    {
        cout << "Usuario: ";
        cin >> u;
        cout << "Clave: ";
        cin >> p;
        if (u == "benjamha" && p == "1525")
        {
            cout << "INICIO DE SESION CORRECTO" << endl;
            return true;
        }
        else
        {
            cout << "Usuario/Clave incorrecto/s" << endl;
        }
    }
    cout << "Limite de intentos alcanzado" << endl;
    return false;
}

int main()
{
    if (!login())
    {
        return 0;
    }
    vector<string> tasks;
    vector<string> tasksPast;
    string newTask;
    int op;
    while (true)
    {
        cout << "PLANIFICADOR DE TAREAS" << endl;
        cout << "1. Ver Tareas" << endl;
        cout << "2. Crear Tarea" << endl;
        cout << "3. Eliminar tarea" << endl;
        cout << "4. Modificar Tarea" << endl;
        cout << "5. Ver historial" << endl;
        cout << "6. Salir" << endl;
        cout << "Ingresar opcion: ";
        cin >> op;
        if (op == 1)
        {
            if (tasks.empty())
            {
                cout << "No hay tareas pendientes" << endl;
            }
            else
            {
                cout << "Listado de tareas:" << endl;
                for (int i = 0; i < tasks.size(); i++)
                {
                    cout << i + 1 << ". " << tasks[i] << endl;
                }
                cout << "Presiona Enter para volver al menu" << endl;
                cin.ignore();
                cin.get();
            }
        }
        else if (op == 2)
        {
            cin.ignore();
            cout << "Nueva tarea: ";
            getline(cin, newTask);
            tasks.push_back(newTask);
            cout << "Tarea añadida." << endl;
            cout << "Presiona Enter para volver al menu" << endl;
            cin.ignore();
            cin.get();
        }
        else if (op == 3)
        {
            cout << "Presiona Enter para volver al menu" << endl;
            cin.ignore();
            cin.get();
        }
        else if (op == 4)
        {
            cout << "Presiona Enter para volver al menu" << endl;
            cin.ignore();
            cin.get();
        }
        else if (op == 5)
        {
            cout << "Presiona Enter para volver al menu" << endl;
            cin.ignore();
            cin.get();
        }
        else if (op == 6)
        {
            break;
        }
        else
        {
            cout << "Opcion no valida" << endl;
        }
    }

    return 0;
}