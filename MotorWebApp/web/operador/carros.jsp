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
                    <table>
                        <tr><td><label for="placa">Placa </label></td><td><input type="text" name="placa" id="placa" required/></td></tr>
                    <tr><td><label for="modelo">Modelo </label></td><td><input type="text" name="modelo" id="modelo" required/></td></tr>
                    <tr><td><label for="marca">Marca </label></td><td><input type="text" name="marca" id="marca" required/></td></tr>
                    <tr><td><label for="ano">Ano </label></td><td><input type="number" name="ano" id="ano" required/></td></tr>
                    <tr><td><label for="cliente">Cliente </label></td><td><select name="cliente" id="cliente">
                        <%try{ ArrayList<Object[]> o = Carros.getClientes(0);
                            for(int i = 0; i < o.size(); i++){
                            Object[] ob = o.get(i);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1] %></option >
                            <%}} catch(Exception ex) {%><option value=" ">Não há clientes</option > <%} %>
                            </select></td></tr>
                    <tr align="right"><td colspan="2"><input type="submit" name="formNewCar" value="Adicionar"/></td></tr>
                    </table>
                </form>
            </fieldset>
            <hr/>
            <%} else {%>
            <fieldset>
                <legend>Alterar Carro de Placa nº: <%= placa %></legend>
                <form>
                    <table
                        <tr><td><label for="placae">Placa </label></td><td><input type="text" name="placa" value="<%= placa %>" id="placae" required/></td></tr>
                        <tr><td><label for="modeloe">Modelo </label></td><td><input type="text" name="modelo" value="<%= modelo %>" id="modeloe" required/></td></tr>
                        <tr><td><label for="marcae">Marca </label></td><td><input type="text" name="marca" value="<%= marca %>" id="marcae" required/></td></tr>
                        <tr><td><label for="anoe">Ano </label></td><td><input type="number" name="ano" value="<%= ano %>" id="anoe" required/></td></tr>
                        <tr><td><input type="hidden" name="id" value="<%= id %>">
                        <tr><td><label for="clientee">Cliente </label></td><td><select name="cliente" id="clientee">
                        <%try{ ArrayList<Object[]> um = Carros.getClientee(id);
                            Object[] ob = um.get(0);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1]%></option><%}catch(Exception ex){}%>
                        <%try{ArrayList<Object[]> o = Carros.getClientes(id);
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
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>PLACA</th>
                    <th>MODELO</th>
                    <th>MARCA</th>
                    <th>ANO</th>
                    <th>CLIENTE</th>
                    <th colspan="2">Ações</th>
                </tr>
                <%for(Carros c: Carros.getCarros()){ %>
                    <tr>
                        <% try{ArrayList<Object[]> um = Carros.getClientee(c.getId());
                            Object[] ob = um.get(0);  %>
                        <td><%= c.getId()%></td>
                        <td><%= c.getPlaca() %></td>
                        <td><%= c.getModelo() %></td>
                        <td><%= c.getMarca() %></td>
                        <td><%= c.getAno() %></td>
                        <td><%= (String) ob[1] %></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar">
                            </form></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formAlterar" value="Alterar">
                        </form></td>
                    </tr>
                <%}catch(Exception ex) {}} %>
            </table>
            <%}%>
    </body>
</html>
