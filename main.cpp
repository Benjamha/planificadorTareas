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
        if (u == "benjamha" && p == "1234")
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

void verTareas(const vector<string> &lista)
{
    if (lista.empty())
    {
        cout << "=====================================" << endl;
        cout << "No hay tareas pendientes" << endl;
        cout << "=====================================" << endl;
    }
    else
    {
        cout << "=====================================" << endl;
        cout << "Listado de tareas:" << endl;
        for (int i = 0; i < lista.size(); i++)
        {
            cout << i + 1 << ". " << lista[i] << endl;
        }
        cout << "=====================================" << endl;
    }
    cout << "Presiona Enter para volver al menu" << endl;
    cin.ignore();
    cin.get();
}

void crearTarea(vector<string> &lista, vector<string> &listaC)
{
    cin.ignore();
    string nuevaTarea;
    cout << "=====================================" << endl;
    cout << "Nueva tarea: ";
    getline(cin, nuevaTarea);
    lista.push_back(nuevaTarea);
    listaC.push_back("[CREADO] " + nuevaTarea);
    cout << "Tarea añadida." << endl;
    cout << "=====================================" << endl;
    cout << "Presiona Enter para volver al menu" << endl;
    cin.get();
}

void eliminarTarea(vector<string> &lista, vector<string> &listaE)
{
    if (lista.empty())
    {
        cout << "No hay tarea para eliminar" << endl;
    }
    else
    {
        for (int i = 0; i < lista.size(); i++)
        {
            cout << i + 1 << ". " << lista[i] << endl;
        }
        int posicion;
        cout << "=====================================" << endl;
        while (true)
        {
            cout << "Escoge la tarea a eliminar: ";
            cin >> posicion;
            if (cin.fail())
            {
                cin.clear();
                cin.ignore(10000, '\n');
                cout << "Debes ingresar un numero valido" << endl;
                continue;
            }
            if (posicion > 0 && posicion < lista.size() + 1)
            {
                char conf;
                while (true)
                {
                    cout << "¿Estas seguro? y/n: ";
                    cin >> conf;

                    if (conf == 'y')
                    {
                        listaE.push_back("[ELIMINADO] " + lista[posicion - 1]);
                        lista.erase(lista.begin() + posicion - 1);
                        cout << "Tarea eliminada" << endl;
                        break;
                    }
                    else if (conf == 'n')
                    {
                        cout << "Eliminacion cancelada" << endl;
                        break;
                    }
                    else
                    {
                        cout << "Ingrese 'y' como si o 'n' como no" << endl;
                    }
                }
                break;
            }
            else
            {
                cout << "La tarea ingresada no existe" << endl;
            }
        }
    }
    cout << "=====================================" << endl;
    cout << "Presiona Enter para volver al menu" << endl;
    cin.ignore();
    cin.get();
}

void modificarTarea(vector<string> &lista, vector<string> &listaM)
{
    string nuevaTarea;
    if (lista.empty())
    {
        cout << "No hay tareas para modificar" << endl;
    }
    else
    {
        for (int i = 0; i < lista.size(); i++)
        {
            cout << i + 1 << ". " << lista[i] << endl;
        }
        int posicion;
        while (true)
        {
            cout << "Escoge la tarea a modificar: ";
            cin >> posicion;
            if (cin.fail())
            {
                cin.clear();
                cin.ignore(10000, '\n');
                cout << "Debes ingresar un numero valido" << endl;
                continue;
            }
            if (posicion > 0 && posicion < lista.size() + 1)
            {
                cout << "Ingrese la nueva tarea: ";
                cin.ignore();
                getline(cin, nuevaTarea);
                char conf;
                while (true)
                {
                    cout << "¿Estas seguro? y/n: ";
                    cin >> conf;
                    if (conf == 'y')
                    {
                        listaM.push_back("[MODIFICADO] " + lista[posicion - 1] + " -> " + nuevaTarea);
                        lista[posicion - 1] = nuevaTarea;
                        cout << "Tarea modificada" << endl;
                        break;
                    }
                    else if (conf == 'n')
                    {
                        cout << "Modificacion cancelada" << endl;
                        break;
                    }
                    else
                    {
                        cout << "Ingrese 'y' como si o 'n' como no" << endl;
                    }
                }
                break;
            }
            else
            {
                cout << "La tarea ingresada no existe" << endl;
            }
        }
    }
    cout << "Presiona Enter para volver al menu" << endl;
    cin.ignore();
    cin.get();
}

void verHistorial(const vector<string> &listaH)
{
    if (listaH.empty())
    {
        cout << "Historial vacio" << endl;
    }
    else
    {
        cout << "HISTORIAL" << endl;
        for (int i = 0; i < listaH.size(); i++)
        {
            cout << listaH[i] << endl;
        }
    }
    cout << "Presiona Enter para volver al menu" << endl;
    cin.ignore();
    cin.get();
}

void menu()
{
    cout << "=====================================" << endl;
    cout << "PLANIFICADOR DE TAREAS" << endl;
    cout << "1. Ver Tareas" << endl;
    cout << "2. Crear Tarea" << endl;
    cout << "3. Eliminar tarea" << endl;
    cout << "4. Modificar Tarea" << endl;
    cout << "5. Ver historial" << endl;
    cout << "6. Salir" << endl;
    cout << "=====================================" << endl;
}

int main()
{
    if (!login())
    {
        return 0;
    }
    vector<string> tasks;
    vector<string> historial;
    bool salir = false;
    while (!salir)
    {
        int op;
        menu();
        cout << "Ingresar opcion: ";
        cin >> op;
        if (cin.fail())
        {
            cin.clear();
            cin.ignore(10000, '\n');
            cout << "Debes ingresar un numero valido" << endl;
            continue;
        }
        switch (op)
        {
        case 1:
            verTareas(tasks);
            break;

        case 2:
            crearTarea(tasks, historial);
            break;

        case 3:
            eliminarTarea(tasks, historial);
            break;

        case 4:
            modificarTarea(tasks, historial);
            break;

        case 5:
            verHistorial(historial);
            break;

        case 6:
            salir = true;
            break;

        default:
            cout << "Opcion no valida" << endl;
        }
    }

    return 0;
}