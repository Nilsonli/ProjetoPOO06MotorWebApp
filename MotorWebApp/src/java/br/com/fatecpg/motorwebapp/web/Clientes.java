package br.com.fatecpg.motorwebapp.web;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author PauloHGama
 */
public class Clientes {
    private long id;
    private String cpf;
    private String nome;
    private String tel;

    public Clientes(long id, String cpf, String nome, String tel) {
        this.id = id;
        this.cpf = cpf;
        this.nome = nome;
        this.tel = tel;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public static ArrayList<Clientes> getClientes() throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM CLIENTE";
        ArrayList<Clientes> cc = new ArrayList<>();
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
                Clientes c = new Clientes(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]);
                cc.add(c);
            }
        }
        return cc;
    }
    
    public static void addClientes(String cpf, String nome, String tel) throws SQLException, ClassNotFoundException
    {   
        String SQL = "INSERT INTO CLIENTE VALUES(default, ?, ?, ?)";
        Object parameters[] = {cpf, nome, tel};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void delClientes(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "DELETE FROM CLIENTE WHERE ID=?";
        Object parameters[] = {id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void altClientes(String cpf, String nome, String tel, long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "UPDATE CLIENTE SET cpf=?, nome=?, tel = ? WHERE ID=?";
        Object parameters[] = {cpf, nome, tel, id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static Clientes getClientesAlterar(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM CLIENTE WHERE ID = ?";
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            Object row[] = list.get(0);
            Clientes c = new Clientes(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]);
                    
            return c;
        }   
    }
}
