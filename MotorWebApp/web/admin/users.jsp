<%-- 
    Document   : Users
    Created on : 25/06/2018, 13:37:18
    Author     : PauloHGama
--%>

<%@page import="br.com.fatecpg.motorwebapp.web.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    if(request.getParameter("formDeletar") != null)
    {
        long id = Long.parseLong(request.getParameter("id"));
        try
        {
            User.delUser(id);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    if(request.getParameter("formNewUser") != null)
    {
        String nome = request.getParameter("nome");
        String role = request.getParameter("role");
        String usuario = request.getParameter("user");
        long senha = request.getParameter("pass").hashCode();
        try
        {
            User.addUser(nome, role, usuario, senha);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
        <title>Usuarios</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1 class="text-center mx-auto display-4">Usuarios</h1>
        <%if(session.getAttribute("user") == null){%>
            <h2 style="color: red">TU NÃO TA LOGADO NÃO MERMÃO</h2>
        <%}else{%>
            <% 
            User user = (User) session.getAttribute("user");
            if(!user.getRole().equals("ADMIN"))
            {
                out.print("<h2 style='color: red'>TU NEM É ADMIN MANO, SAI DAQUI</h2>");
            }
            else { if(error!=null) out.print("<h2>" + error + "</h2>");%>
            <div class="container-fluid border border-success mx-center text-center">
            <fieldset>
            <legend>Novo usuario</legend>
                <form>
                    <table class="mx-auto text-center">
                        <tr><td><label for="role">Papel </label></td><td><select name="role" id="role">
                                                        <option value="ADMIN">ADMIN</option >
                                                        <option value="OPERADOR">OPERADOR</option>     
                                                    </select></td></tr>
                    <tr><td><label for="nome">Nome </label></td><td><input type="text" name="nome" id="nome" required/></td></tr>
                    <tr><td><label for="user">Usuario </label></td><td><input type="text" name="user" id="user" required/></td></tr>
                    <tr><td><label for="pass">Senha </label></td><td><input type="password" name="pass" id="pass" required/></td></tr>
                    <tr align="right"><td colspan="2"><input type="submit" name="formNewUser" value="Adicionar" class="btn btn-success"/></td></tr>
                    </table>
                </form>
            </fieldset>
            </div>
            <br/>
            <div class="container-fluid border border-success mx-center text-center">
                <br/>
            <table border="1" class="mx-auto text-center">
                <tr>
                    <th>ID</th>
                    <th>PAPEL</th>
                    <th>NOME</th>
                    <th>LOGIN</th>
                    <th>Ação</th>
                </tr>
                <%for(User u: User.getUsers()){ %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getRole()%></td>
                        <td><%= u.getName()%></td>
                        <td><%= u.getLogin()%></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= u.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar" class="btn-danger">
                            </form></td>
                    </tr>
                <%}%>
            </table>
            <%}
        %>
        <%}%>
        <br/>
            </div>
    </body>
</html>