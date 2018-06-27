package br.com.fatecpg.motorwebapp.web;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.derby.client.am.Decimal;

/**
 *
 * @author PauloHGama
 */
public class Consertos {
    private long id;
    private int placa;
    private int mecanico;
    private String peca;
    private Double preco;

    public Consertos(long id, int placa, int mecanico, String peca, Double preco) {
        this.id = id;
        this.placa = placa;
        this.mecanico = mecanico;
        this.peca = peca;
        this.preco = preco;
    }

    public static ArrayList<Consertos> getConsertos() throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM CONSERTO";
        ArrayList<Consertos> consertos = new ArrayList<>();
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
                Consertos u = new Consertos(
                    (long)row[0]
                    , (int) row[1]
                    , (int) row[2]
                    , (String) row[3]
                    , (Double) row[4]);
                consertos.add(u);
            }
        }
        return consertos;
    }

    public static void addConsertos(int placa, int mecanico, String peca, Double preco) throws SQLException, ClassNotFoundException
    {   
        String SQL = "INSERT INTO CONSERTO VALUES(default, ?, ?, ?, ?)";
        Object parameters[] = {placa, mecanico, peca, preco};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void delConsertos(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "DELETE FROM CONSERTO WHERE ID=?";
        Object parameters[] = {id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void altConsertos(String placa, String mecanico, String peca, Double preco, long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "UPDATE CONSERTO SET CARRO=?, MECANICO=?, PECA=?, PRECO=? WHERE ID=?";
        Object parameters[] = {placa, mecanico, peca, preco, id};
        DatabaseConnector.setQuery(SQL, parameters);
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getPlaca() {
        return placa;
    }

    public void setPlaca(int placa) {
        this.placa = placa;
    }

    public int getMecanico() {
        return mecanico;
    }
    
        
      public static String getMecanicos(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT NOME FROM MECANICO WHERE ID=?";
        String mecanicos;
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
                Object row[] = list.get(0);
                mecanicos = (String)row[0];
        }
        return mecanicos;
    }
      
 /*         public static ArrayList<Object[]> getClientes(long id) throws SQLException, ClassNotFoundException
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
    }*/
    
    public void setMecanico(int mecanico) {
        this.mecanico = mecanico;
    }

    public String getPeca() {
        return peca;
    }

    public void setPeca(String peca) {
        this.peca = peca;
    }

    public Double getPreco() {
        return preco;
    }

    public void setPreco(Double preco) {
        this.preco = preco;
    }
}

