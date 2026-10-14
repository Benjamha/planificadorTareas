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

void crearTarea(vector<string> &lista, string nuevaTarea, vector<string> &listaC)
{
    cin.ignore();
    cout << "=====================================" << endl;
    cout << "Nueva tarea: ";
    getline(cin, nuevaTarea);
    lista.push_back(nuevaTarea);
    listaC.push_back(nuevaTarea);
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
                        listaE.push_back(lista[posicion - 1]);
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

void modificarTarea(vector<string> &lista, vector<string> &listaM, string nuevaTarea)
{
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
                        listaM.push_back(lista[posicion - 1]);
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

void verHistorial(const vector<string> &lista, const vector<string> &listaC, const vector<string> &listaE, const vector<string> &listaM)
{
    if (listaE.empty() && listaM.empty() && listaC.empty())
    {
        cout << "Historial vacio" << endl;
    }
    else
    {
        cout << "HISTORIAL" << endl;
        if (!listaE.empty())
        {
            string status;
            for (int i = 0; i < listaE.size(); i++)
            {
                cout << "[ELIMINADO] " << listaE[i] << endl;
            }
        }
        if (!listaM.empty())
        {
            string status;
            for (int i = 0; i < listaM.size(); i++)
            {
                cout << "[MODIFICADO] " << listaM[i] << endl;
            }
        }
        if (!listaC.empty())
        {
            string status;
            for (int i = 0; i < listaC.size(); i++)
            {
                cout << "[CREADA] " << listaC[i] << endl;
            }
        }
    }
    cout << "Presiona Enter para volver al menu" << endl;
    cin.ignore();
    cin.get();
}

int main()
{
    if (!login())
    {
        return 0;
    }
    vector<string> tasks;
    vector<string> tasksPastE;
    vector<string> tasksPastC;
    vector<string> tasksPastM;
    vector<string> historialGeneral;
    string newTask;
    int op;
    while (true)
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
        cout << "Ingresar opcion: ";
        cin >> op;
        if (cin.fail())
        {
            cin.clear();
            cin.ignore(10000, '\n');
            cout << "Debes ingresar un numero valido" << endl;
            continue;
        }
        if (op == 1)
        {
            verTareas(tasks);
        }
        else if (op == 2)
        {
            crearTarea(tasks, newTask, tasksPastC);
        }
        else if (op == 3)
        {
            eliminarTarea(tasks, tasksPastE);
        }
        else if (op == 4)
        {
            modificarTarea(tasks, tasksPastE, newTask);
        }
        else if (op == 5)
        {
            verHistorial(tasks, tasksPastC, tasksPastE, tasksPastM);
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