package br.com.fatecpg.motorwebapp.web;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author PauloHGama
 */
public class Carros {
    long id;
    String placa;
    String modelo;
    String marca;
    int ano;
    int cliente;

    public Carros(long id, String placa, String modelo, String marca, int ano, int cliente) {
        this.id = id;
        this.placa = placa;
        this.modelo = modelo;
        this.marca = marca;
        this.ano = ano;
        this.cliente = cliente;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public int getCliente() {
        return cliente;
    }

    public void setCliente(int cliente) {
        this.cliente = cliente;
    }
    
    public static ArrayList<Carros> getCarros() throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM CARRO";
        ArrayList<Carros> cars = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            for(int i = 0; i < list.size(); i++)
            {
                Object row[] = list.get(i);
                Carros c = new Carros(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]
                    , (int) row[4]
                    , (int) row[5]);
                cars.add(c);
            }
        }
        return cars;
    }
    public static void addCarro(String placa, String modelo, String marca, int ano, int cliente) throws SQLException, ClassNotFoundException
    {   
        String SQL = "INSERT INTO CARRO VALUES(default, ?, ?, ?, ?, ?)";
        Object parameters[] = {placa, modelo, marca, ano, cliente};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void delCarro(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "DELETE FROM CARRO WHERE ID=?";
        Object parameters[] = {id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void altCarros(String placa, String modelo, String marca, int ano, int cliente, long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "UPDATE CARRO SET placa=?, modelo=?, marca=?, ano=?, cliente=? WHERE ID=?";
        Object parameters[] = {placa, modelo, marca, ano, cliente, id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static Carros getCarrosAlterar(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM CARRO WHERE ID = ?";
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            Object row[] = list.get(0);
            Carros c = new Carros(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]
                    , (int) row[4]
                    , (int) row[5]);
            return c;
        }   
    }
    public static ArrayList<Object[]> getClientes(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT id, nome FROM CLIENTE WHERE ID<>?";
        ArrayList<Object[]> clientes = new ArrayList<>();
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            for(int i = 0; i < list.size(); i++)
            {
                Object row[] = list.get(i);
                clientes.add(row);
            }
        }
        return clientes;
    }
    public static ArrayList<Object[]> getClientee(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT CLIENTE.ID, CLIENTE.NOME FROM CLIENTE, CARRO WHERE CARRO.ID = CLIENTE.ID AND CARRO.CLIENTE = ?";
        ArrayList<Object[]> clientes = new ArrayList<>();
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            for(int i = 0; i < list.size(); i++)
            {
                Object row[] = list.get(i);
                clientes.add(row);
            }
        }
        return clientes;
    }
}
