<%-- 
    Document   : perfil
    Created on : 25/06/2018, 16:32:49
    Author     : PauloHGama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User users = (User) session.getAttribute("user");
    String senhaantiga = "";
    String senhanaoiguais = "";
    if(request.getParameter("formAlt") != null)
    {
        long pass = request.getParameter("pass").hashCode();
        long confpass = request.getParameter("confpass").hashCode();
        if(pass != confpass)
        {
            senhanaoiguais = "Senhas não coincidem";
        }
        else
        {
            long antpass = request.getParameter("antpass").hashCode();
            if(antpass != users.getPasswordHash())
            {
                senhaantiga = "Senha antiga invalida";
            }
            else
            {
                User u = new User(users.getId(), users.getRole(), users.getName(), users.getLogin(), request.getParameter("pass").hashCode());
                User.altUser(u.getRole(), u.getName(), u.getLogin(), u.getPasswordHash(), u.getId());
                response.sendRedirect(request.getRequestURI());
            }
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h1>Perfil</h1>
        <%if(session.getAttribute("user") == null){%>
            <h2 style="color: red">TU NÃO TA LOGADO NÃO MERMÃO</h2>
        <%}else{
            User userss = (User) session.getAttribute("user");%>
            <fieldset>
            <legend>Perfil</legend>
                <form>
                    <table border="0">
                    <tr><td>Papel </td><td><select name="role" id="role">
                        <%if(userss.getRole().equals("ADMIN")){ %><option value="ADMIN">ADMIN</option ><option value="OPERADOR">OPERADOR</option> <%}%>    
                        <%if(userss.getRole().equals("OPERADOR")){ %><option value="OPERADOR">OPERADOR</option><option value="ADMIN">ADMIN</option > <%}%>    
                            </select></td><td></td></tr>
                    <tr><td>Nome</td><td><input type="text" name="nome" value="<%= users.getName() %>" id="nome" required/></td><td></td></tr>
                    <tr><td>Usuario </td><td><input type="text" name="user" value="<%= users.getLogin() %>" id="user" required/></td><td></td></tr>
                    <tr><td>Senha Antiga</td><td><input type="password" name="antpass" id="antpass" required/></td><td style="color: red"><b><%= senhaantiga %></b></td></tr>
                    <tr><td>Senha </td><td><input type="password" name="pass" id="pass" required/></td><td></td></tr>
                    <tr><td>Confirmar Senha </td><td><input type="password" name="confpass" id="confpass" required/></td><td  style="color: red"><b><%= senhanaoiguais  %></b></td></tr>
                    <tr align="right"><td colspan="2"><input type="submit" name="formAlt" value="Alterar"/></td><td></td></tr>
                    </table>
                </form>
            </fieldset>
           <%}%>                 
    </body>
</html>
