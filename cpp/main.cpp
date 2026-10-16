#include <iostream>
#include <string>
#include <vector>
#include <cctype>
#include <fstream>

using namespace std;

struct Tarea
{
    string titulo;
    bool completada = false;
    int prioridad = 1;
};

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

void pausa()
{
    cout << "Presiona Enter para regresar al menu" << endl;
    cin.get();
}

void cargarTarea(const string &archivo, vector<Tarea> &lista)
{
    ifstream entrada(archivo);
    if (!entrada.is_open())
    {
        return;
    }
    Tarea t;
    while (entrada >> t.completada >> t.prioridad)
    {
        entrada.ignore();
        getline(entrada, t.titulo);
        lista.push_back(t);
    }
}

void guardarTarea(const string &archivo, const vector<Tarea> &lista)
{
    ofstream salida(archivo);
    if (!salida.is_open())
    {
        cout << "No se pudo guardar " << archivo << endl;
        return;
    }
    for (const Tarea &t : lista)
    {
        salida << t.completada << " " << t.prioridad << " " << t.titulo << endl;
    }
}

void cargarLista(const string &archivo, vector<string> &lista)
{
    ifstream entrada(archivo);
    if (!entrada.is_open())
    {
        return;
    }
    string linea;
    while (getline(entrada, linea))
    {
        if (!linea.empty())
        {
            lista.push_back(linea);
        }
    }
}

void guardarLista(const string &archivo, const vector<string> &lista)
{
    ofstream salida(archivo);
    if (!salida.is_open())
    {
        cout << "No se pudo guardar " << archivo << endl;
        return;
    }
    for (const string &elemento : lista)
    {
        salida << elemento << endl;
    }
}

int validarOpcion(const string &mensaje)
{
    int n;
    while (true)
    {
        cout << mensaje;
        cin >> n;
        if (cin.fail())
        {
            cin.clear();
            cin.ignore(10000, '\n');
            cout << "Debes ingresar un numero valido" << endl;
            continue;
        }
        cin.ignore(10000, '\n');
        return n;
    }
}

bool tarea_enBlanco(string tarea)
{
    if (tarea.empty())
    {
        cout << "Tarea en blanco, no creada" << endl;
        return false;
    }
    else
    {
        return true;
    }
}

bool confirmar()
{
    char conf;
    while (true)
    {
        cout << "¿Estas seguro? y/n: ";
        cin >> conf;
        cin.ignore(10000, '\n');
        conf = tolower(conf);
        if (conf == 'y')
        {
            return true;
        }
        else if (conf == 'n')
        {
            return false;
        }
        else
        {
            cout << "Ingrese 'y' como si o 'n' como no" << endl;
        }
    }
}

void verTareas(const vector<Tarea> &lista)
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
            cout << i + 1 << ". [" << (lista[i].completada ? "x" : " ") << "] " << lista[i].titulo << endl;
        }
        cout << "=====================================" << endl;
    }
    pausa();
}

void crearTarea(vector<Tarea> &lista, vector<string> &listaC)
{
    string nuevaTarea;
    cout << "=====================================" << endl;
    cout << "Nueva tarea: ";
    getline(cin, nuevaTarea);
    if (tarea_enBlanco(nuevaTarea))
    {
        Tarea t;
        t.titulo = nuevaTarea;
        lista.push_back(t);
        listaC.push_back("[CREADO] " + nuevaTarea);
        cout << "Tarea añadida." << endl;
        cout << "=====================================" << endl;
    }
    pausa();
}

void eliminarTarea(vector<Tarea> &lista, vector<string> &listaE)
{
    if (lista.empty())
    {
        cout << "No hay tarea para eliminar" << endl;
    }
    else
    {
        for (int i = 0; i < lista.size(); i++)
        {
            cout << i + 1 << ". " << lista[i].titulo << endl;
        }
        cout << "=====================================" << endl;
        while (true)
        {
            int posicion = validarOpcion("Escoge la tarea a eliminar: ");
            if (posicion > 0 && posicion < lista.size() + 1)
            {
                if (confirmar())
                {
                    listaE.push_back("[ELIMINADO] " + lista[posicion - 1].titulo);
                    lista.erase(lista.begin() + posicion - 1);
                    cout << "Tarea eliminada" << endl;
                }
                else
                {
                    cout << "Eliminacion cancelada" << endl;
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
    pausa();
}

void modificarTarea(vector<Tarea> &lista, vector<string> &listaM)
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
            cout << i + 1 << ". " << lista[i].titulo << endl;
        }
        while (true)
        {
            int posicion = validarOpcion("Escoge la tarea a modificar: ");
            if (posicion > 0 && posicion < lista.size() + 1)
            {
                cout << "Ingrese la nueva tarea: ";
                getline(cin, nuevaTarea);
                if (tarea_enBlanco(nuevaTarea))
                {
                    if (confirmar())
                    {
                        listaM.push_back("[MODIFICADO] " + lista[posicion - 1].titulo + " -> " + nuevaTarea);
                        lista[posicion - 1].titulo = nuevaTarea;
                        cout << "Tarea modificada" << endl;
                    }
                    else
                    {
                        cout << "Modificacion cancelada" << endl;
                    }
                    break;
                }
            }
            else
            {
                cout << "La tarea ingresada no existe" << endl;
            }
        }
    }
    pausa();
}

void completarTarea(vector<Tarea> &lista, vector<string> &listaH)
{
    if (lista.empty())
    {
        cout << "No existen tareas. Crea una para comenzar a interactuar" << endl;
    }
    else
    {
        for (int i = 0; i < lista.size(); i++)
        {
            cout << i + 1 << ". [" << (lista[i].completada ? "x" : " ") << "] " << lista[i].titulo << endl;
        }
        cout << "=====================================" << endl;
        while (true)
        {
            int posicion;
            cout << "Escoge tarea completada: ";
            cin >> posicion;
            if (posicion > 0 && posicion < lista.size() + 1)
            {
                if (lista[posicion - 1].completada)
                {
                    cout << "La tarea seleccionada ya esta completada" << endl;
                }
                else
                {
                    lista[posicion - 1].completada = true;
                    listaH.push_back("[COMPLETADO] " + lista[posicion - 1].titulo);
                    cout << "Tarea completada" << endl;
                }
                break;
            }
            else
            {
                cout << "La tarea ingreada no existe" << endl;
            }
        }
    }
    pausa();
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
    pausa();
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
    cout << "6. Marcar tarea como completada" << endl;
    cout << "7. Salir" << endl;
    cout << "=====================================" << endl;
}

int main()
{
    if (!login())
    {
        return 0;
    }
    vector<Tarea> tasks;
    vector<string> historial;
    cargarTarea("Tareas.txt", tasks);
    cargarLista("Historial.txt", historial);
    bool salir = false;
    while (!salir)
    {
        menu();
        int op = validarOpcion("Ingresa una opcion: ");
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
            completarTarea(tasks, historial);
            break;

        case 7:
            salir = true;
            break;

        default:
            cout << "Opcion no valida" << endl;
        }
        guardarTarea("Tareas.txt", tasks);
        guardarLista("Historial.txt", historial);
    }

    return 0;
}