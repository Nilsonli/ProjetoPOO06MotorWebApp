<%-- 
    Document   : carros
    Created on : 25/06/2018, 14:48:04
    Author     : PauloHGama
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
    Date d = new Date();
    d.getYear();
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
         <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
        <title>Carros</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1 class="text-center mx-auto display-4">Carros</h1>
        <%if(session.getAttribute("user") == null){%>
            <h2 style="color: red">TU NÃO TA LOGADO NÃO MERMÃO</h2>
        <%}else{%>
            <% 
            if(error!=null) out.print("<h2>" + error + "</h2>");%>
            <% if(request.getParameter("formAlterar") == null) {%>
            <div class="container-fluid border border-success mx-center text-center">
            <fieldset>
            <legend>Novo Carro</legend>
                <form>
                    <table class="mx-auto text-center">
                        <tr><td><label for="placa">Placa </label></td><td><input type="text" name="placa" maxlength="7" id="placa" required/></td></tr>
                    <tr><td><label for="modelo">Modelo </label></td><td><input type="text" name="modelo" id="modelo" required/></td></tr>
                    <tr><td><label for="marca">Marca </label></td><td><input type="text" name="marca" id="marca" required/></td></tr>
                    <tr><td><label for="ano">Ano </label></td><td><input type="number" name="ano" max="<%=(d.getYear()+1900)%>" min="1940" id="ano" required/></td></tr>
                    <tr><td><label for="cliente">Cliente </label></td><td><select name="cliente" id="cliente" required>
                        <% ArrayList<Object[]> o = Carros.getClientes(0);
                            try{for(int i = 0; i < o.size(); i++){
                            Object[] ob = o.get(i);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1] %></option >
                            <%}}
                            catch(Exception ex) {%>
                            <option value="null" disabled>Não há clientes</option>
                            <%}%>
                            </select></td></tr>
                    <tr align="center"><td colspan="2"><input type="submit" name="formNewCar" value="Adicionar" class="btn btn-success"/></td></tr>
                    </table>
                </form>
            </fieldset>
            </div>
            <hr/>
            <%} else {%>
            <fieldset>
                <legend>Alterar Carro de Placa nº: <%= placa %></legend>
                <form>
                    <table
                        <tr><td><label for="placae">Placa </label></td><td><input type="text" name="placa" maxlength="7" value="<%= placa %>" id="placae" required/></td></tr>
                        <tr><td><label for="modeloe">Modelo </label></td><td><input type="text" name="modelo" value="<%= modelo %>" id="modeloe" required/></td></tr>
                        <tr><td><label for="marcae">Marca </label></td><td><input type="text" name="marca" value="<%= marca %>" id="marcae" required/></td></tr>
                        <tr><td><label for="anoe">Ano </label></td><td><input type="number" name="ano" max="<%= (d.getYear()+1900) %>" min="1940" value="<%= ano %>" id="anoe" required/></td></tr>
                        <tr><td><input type="hidden" name="id" value="<%= id %>">
                        <tr><td><label for="clientee">Cliente </label></td><td><select name="cliente" id="clientee">
                        <% ArrayList<Object[]> um = Carros.getClientee(id);
                            Object[] ob = um.get(0);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1] %></option >
                        <%  ArrayList<Object[]> o = Carros.getClientes(id);
                            try{
                            for(int i = 0; i < o.size(); i++){
                            Object[] obj = o.get(i);  %>
                            <option value="<%= (long) obj[0] %>"><%= (String) obj[1] %></option >
                            <%}} catch(Exception ex) {} %>
                            </select></td></tr>
                        <tr align="right"><td colspan="2"><input type="submit" name="executaAlterar" value="Alterar"/></td></tr>
                    </table>
                </form>
            </fieldset>
            <hr/>
         
            <%}%>
            <div class="container-fluid border border-success mx-center text-center">
                <br/>
            <table border="1" class="mx-auto text-center">
                <tr>
                    <th>ID</th>
                    <th>PLACA</th>
                    <th>MODELO</th>
                    <th>MARCA</th>
                    <th>ANO</th>
                    <th>CLIENTE</th>
                    <th colspan="2">Ações</th>
                </tr>
                <%try {
                    for(Carros c: Carros.getCarros()){
                    %>
                    <tr>
                        <% ArrayList<Object[]> um = Carros.getClientee(c.getCliente());
                            Object[] ob = um.get(0);  %>
                        <td><%= c.getId()%></td>
                        <td><%= c.getPlaca() %></td>
                        <td><%= c.getModelo() %></td>
                        <td><%= c.getMarca() %></td>
                        <td><%= c.getAno() %></td>
                        <td><%= (String) ob[1] %></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar"  class="btn btn-danger">
                            </form></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formAlterar" value="Alterar" class="btn btn-warning">
                        </form></td>
                    </tr>
                    <%}} catch(Exception ex){} %>
            </table>
            <br/>
            </div>
            <%}%>
    </body>
</html>
