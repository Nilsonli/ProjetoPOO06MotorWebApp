<%-- 
    Document   : consertos
    Created on : 25/06/2018, 21:44:39
    Author     : PauloHGama
--%>

<%@page import="br.com.fatecpg.motorwebapp.web.Consertos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String error = null;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agenda de Consertos</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Consertos</h1>
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
            <fieldset>
                <legend>Cadastrar Conserto</legend>
                <form>
                    Placa Do Carro <input type="text" name="placa" id="placa" required="">
                    Mecanico Responsável <input type="text" name="mecanico" id="mecanico" required>
                    Peça Utilizada <input type="text" name="peca" id="peca" required>
                    Valor do conserto <input type="number" name="preco" id="preco" required>
                    <input type="submit" name="addNewConserto" value="Confirmar">
                    <input type="reset" name="resetForm" value="Cancelar">
                </form>
            </fieldset>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Placa</th>
                    <th>Mecanico</th>
                    <th>Peça</th>
                    <th>Preço</th>
                </tr>
                <% out.print("todo algoritimo for para exibir");%>
                <% try{ for(Consertos u: Consertos.getConsertos()){%>
               <tr>
                   <td><%= u.getId()%></td>
                    <td><%= u.getPlaca() %></td>
                    <td><%= u.getNomeMecanico() %></td>
                    <td><%= u.getPeca() %></td>
                    <td><%= u.getPreco() %></td>
                </tr>
                <%}}catch(Exception ex){out.print(ex.getMessage());}%>
            </table>
            <%}}%>
    </body>
</html>
