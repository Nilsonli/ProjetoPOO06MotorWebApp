package br.com.fatecpg.motorwebapp.web;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author PauloHGama
 */
public class Consertos {
    private long id;
    private String placa;
    private String mecanico;
    private String peca;
    private Double preco;

    public Consertos(long id, String placa, String mecanico, String peca, Double preco) {
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
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]
                    , (Double) row[4]);
                consertos.add(u);
            }
        }
        return consertos;
    }

    public static void addConsertos(String placa, String mecanico, String peca, Double preco) throws SQLException, ClassNotFoundException
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

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getMecanico() {
        return mecanico;
    }

    public void setMecanico(String mecanico) {
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

