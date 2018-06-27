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
    private BigDecimal preco;

    public Consertos(long id, int placa, int mecanico, String peca, BigDecimal preco) {
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
                    , (BigDecimal) row[4]);
                consertos.add(u);
            }
        }
        return consertos;
    }

    public static void addConsertos(int placa, int mecanico, String peca, BigDecimal preco) throws SQLException, ClassNotFoundException
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
    public static void altConsertos(String placa, String mecanico, String peca, BigDecimal preco, long id) throws SQLException, ClassNotFoundException
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
  
    public String getNomeMecanico() throws SQLException, ClassNotFoundException {
        id = this.mecanico;
        String SQL = "SELECT * FROM MECANICO WHERE ID=?";
        String nome = new String();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
                if(list.isEmpty())
                {
                    return null;
                }    
                else
                {
                Object row[] = list.get(0);
                nome = (String) row[0];
                }
                return nome;

    }

    public void setMecanico(int mecanico) {
        this.mecanico = mecanico;
    }

    public String getPeca() {
        return peca;
    }

    public void setPeca(String peca) {
        this.peca = peca;
    }

    public BigDecimal getPreco() {
        return preco;
    }

    public void setPreco(BigDecimal preco) {
        this.preco = preco;
    }
}

