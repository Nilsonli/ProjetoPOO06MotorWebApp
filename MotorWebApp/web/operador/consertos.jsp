<%-- 
    Document   : consertos
    Created on : 25/06/2018, 21:44:39
    Author     : PauloHGama
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Consertos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String error = null;
        if(request.getParameter("formDeletar") != null)
    {
        long id = Long.parseLong(request.getParameter("id"));
        try
        {
            Consertos.delConsertos(id);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
        if(request.getParameter("addNewConserto") != null)
    {
        int placa = Integer.parseInt(request.getParameter("placa"));
        int mecanico = Integer.parseInt(request.getParameter("mecanico"));
        String peca = request.getParameter("peca");
        Double preco = Double.parseDouble(request.getParameter("preco"));
        try
        {
            Consertos.addConsertos(placa,mecanico,peca,preco);
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
                    ID Carro <input type="number" step="1" name="placa" id="placa" required="">
                    ID Mecanico <input type="number" step="1" name="mecanico" id="mecanico" required>
                    Peça Utilizada <input type="text" name="peca" id="peca" required>
                    Valor do conserto <input type="number" name="preco" step="0.1" id="preco" required>
                    <input type="submit" name="addNewConserto" value="Confirmar">
                    <input type="reset" name="resetForm" value="Cancelar">
                </form>
            </fieldset>
            <br/>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Placa</th>
                    <th>Mecanico</th>
                    <th>Peça</th>
                    <th>Preço</th>
                </tr>
                <% try{ for(Consertos u: Consertos.getConsertos()){%>
               <tr>
                   <td><%= u.getId()%></td>
                    <td><%= u.getPlaca() %></td>
                    <td><%= u.getMecanico() %></td>
                    <td><%= u.getPeca() %></td>
                    <td><%= u.getPreco() %>0</td>
                    <td><form>
                        <input type="hidden" name="id" value="<%= u.getId() %>"/>
                        <input type="submit" name="formDeletar" value="Deletar">
                    </form></td>
                    <td><form>
                        <input type="hidden" name="id" value="<%= u.getId() %>"/>
                        <input type="submit" name="formAlterar" value="Alterar">
                    </form>
                        
                    </td>
                </tr>
                <%}}catch(Exception ex){}%>
            </table>
            <%}}%>
    </body>
</html>
