package br.com.fatecpg.motorwebapp.web;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author PauloHGama
 */
public class User {
    private long id;
    private String role;
    private String name;
    private String login;
    private long passwordHash;

    public User(long id, String role, String name, String login, long passwordHash) {
        this.id = id;
        this.role = role;
        this.name = name;
        this.login = login;
        this.passwordHash = passwordHash;
    }
    
    

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public long getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(long passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public static User getUser(String login, String pass) throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM USERS WHERE login = ? AND passwordhash = ?";
        Object parameters[] = {login, pass.hashCode()};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if(list.isEmpty())
        {
            return null;
        }    
        else
        {
            Object row[] = list.get(0);
            User u = new User(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]
                    , (long) row[4]);
            return u;
        }   
    }
    public static ArrayList<User> getUsers() throws SQLException, ClassNotFoundException
    {   
        String SQL = "SELECT * FROM USERS";
        ArrayList<User> users = new ArrayList<>();
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
                User u = new User(
                    (long)row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (String) row[3]
                    , (long) row[4]);
                users.add(u);
            }
        }
        return users;
    }
    public static void addUser(String nome, String role, String login, long pass) throws SQLException, ClassNotFoundException
    {   
        String SQL = "INSERT INTO USERS VALUES(default, ?, ?, ?, ?)";
        Object parameters[] = {role, nome, login, pass};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void delUser(long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "DELETE FROM USERS WHERE ID=?";
        Object parameters[] = {id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
    public static void altUser(String role, String name, String login, long pass, long id) throws SQLException, ClassNotFoundException
    {   
        String SQL = "UPDATE USERS SET role=?, name=?, login=?, passwordhash=? WHERE ID=?";
        Object parameters[] = {role, name, login, pass, id};
        DatabaseConnector.setQuery(SQL, parameters);
    }
}

