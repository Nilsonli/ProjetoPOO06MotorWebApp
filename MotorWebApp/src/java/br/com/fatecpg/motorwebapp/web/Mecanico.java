package br.com.fatecpg.motorwebapp.web;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author ASUS
 */
public class Mecanico {
    private long id;
    private String cpf;
    private String nome;

public Mecanico(long id, String cpf, String nome) {
         
        this.id = id;
        this.cpf = cpf;
        this.nome = nome;
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
    
     public static ArrayList<Mecanico> getMecanico() throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM MECANICO";
        ArrayList<Mecanico> mecanic = new ArrayList<>();
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
                Mecanico m = new Mecanico(
                    (long)row[0]
                  , (String) row[1]
                  , (String) row[2]);
                    
                mecanic.add(m);
            }
        }
        return mecanic;
    }
    public static void addMecanico(String cpf, String nome) throws SQLException, ClassNotFoundException
    {   
        String SQL = "INSERT INTO MECANICO VALUES(default, ?, ?)";
        Object parameters[] = {cpf, nome};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void delMecanico(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "DELETE FROM MECANICO WHERE ID=?";
        Object parameters[] = {id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void altMecanico(String cpf, String nome, long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "UPDATE MECANICO SET cpf=?, nome=? WHERE ID=?";
        Object parameters[] = {cpf, nome, id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static Mecanico getMecanicoAlterar(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM MECANICO WHERE ID = ?";
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            Object row[] = list.get(0);
            Mecanico m = new Mecanico(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]);
                    
            return m;
        }   
    }
  
}
