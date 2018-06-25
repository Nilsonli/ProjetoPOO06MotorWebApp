<%-- 
    Document   : carros
    Created on : 25/06/2018, 14:48:04
    Author     : PauloHGama
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Carros"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    String placa = "";
    String marca = "";
    String modelo = "";
    int ano = 0;
    int cliente = 0;
    long id = 0;
    if(request.getParameter("formDeletar") != null)
    {
        id = Long.parseLong(request.getParameter("id"));
        try
        {
            Carros.delCarro(id);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    if(request.getParameter("formAlterar") != null)
    {
        Carros c = Carros.getCarrosAlterar(Long.parseLong(request.getParameter("id")));
        id = c.getId();
        placa = c.getPlaca();
        marca = c.getMarca();
        modelo = c.getModelo();
        ano = c.getAno();
        cliente = c.getCliente();
        response.sendRedirect(request.getRequestURI());
    }
    if(request.getParameter("formNewCar") != null)
    {
        placa = request.getParameter("placa");
        marca = request.getParameter("marca");
        modelo = request.getParameter("modelo");
        ano = Integer.parseInt(request.getParameter("ano"));
        cliente = Integer.parseInt(request.getParameter("cliente"));
        try
        {
            Carros.addCarro(placa, modelo, marca, ano, cliente);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    if(request.getParameter("executaAlterar") != null)
    {
        placa = request.getParameter("placa");
        marca = request.getParameter("marca");
        modelo = request.getParameter("modelo");
        ano = Integer.parseInt(request.getParameter("ano"));
        cliente = Integer.parseInt(request.getParameter("cliente"));
        id = Long.parseLong(request.getParameter("id"));
        try
        {
            Carros.altCarros(placa, modelo, marca, ano, cliente, id);
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
        <title>Carros</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Carros</h1>
        <%if(session.getAttribute("user") == null){%>
            <h2 style="color: red">TU NÃO TA LOGADO NÃO MERMÃO</h2>
        <%}else{%>
            <% 
            if(error!=null) out.print("<h2>" + error + "</h2>");%>
            <% if(request.getParameter("formAlterar") == null) {%>
            <fieldset>
            <legend>Novo Carro</legend>
                <form>
                    
                    <label for="placa">Placa </label><input type="text" name="placa" id="placa" required/>
                    <label for="modelo">Modelo </label><input type="text" name="modelo" id="modelo" required/>
                    <label for="marca">Marca </label><input type="text" name="marca" id="marca" required/>
                    <label for="ano">Ano </label><input type="number" name="ano" id="ano" required/>
                    <label for="cliente">Cliente </label><select name="cliente" id="cliente">
                        <% ArrayList<Object[]> o = Carros.getClientes(0);
                            for(int i = 0; i < o.size(); i++){
                            Object[] ob = o.get(i);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1] %></option >
                            <%}%>
                            </select>
                    <input type="submit" name="formNewCar" value="Adicionar"/>
                </form>
            </fieldset>
            <hr/>
            <%} else {%>
            <fieldset>
                <legend>Alterar Carro de Placa nº: <%= placa %></legend>
                <form>
                    
                    <label for="placae">Placa </label><input type="text" name="placa" value="<%= placa %>" id="placae" required/>
                    <label for="modeloe">Modelo </label><input type="text" name="modelo" value="<%= modelo %>" id="modeloe" required/>
                    <label for="marcae">Marca </label><input type="text" name="marca" value="<%= marca %>" id="marcae" required/>
                    <label for="anoe">Ano </label><input type="number" name="ano" value="<%= ano %>" id="anoe" required/>
                    <input type="hidden" name="id" value="<%= id %>">
                    <label for="clientee">Cliente </label><select name="cliente" id="clientee">
                        <% ArrayList<Object[]> um = Carros.getClientee(id);
                            Object[] ob = um.get(0);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1] %></option >
                        <%  ArrayList<Object[]> o = Carros.getClientes(id);
                            if(o != null){
                            for(int i = 0; i < o.size(); i++){
                            Object[] obj = o.get(i);  %>
                            <option value="<%= (long) obj[0] %>"><%= (String) obj[1] %></option >
                            <%}}%>
                            </select>
                    <input type="submit" name="executaAlterar" value="Alterar"/>
                </form>
            </fieldset>
            <hr/>
            <%}%>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>PLACA</th>
                    <th>MODELO</th>
                    <th>MARCA</th>
                    <th>ANO</th>
                    <th colspan="2">Ações</th>
                </tr>
                <%for(Carros c: Carros.getCarros()){ %>
                    <tr>
                        <td><%= c.getId()%></td>
                        <td><%= c.getPlaca() %></td>
                        <td><%= c.getModelo() %></td>
                        <td><%= c.getMarca() %></td>
                        <td><%= c.getAno() %></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar">
                            </form></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formAlterar" value="Alterar">
                        </form></td>
                    </tr>
                <%}%>
            </table>
            <%}%>
    </body>
</html>
