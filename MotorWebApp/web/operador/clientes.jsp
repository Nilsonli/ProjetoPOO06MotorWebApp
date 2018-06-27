<%-- 
    Document   : carros
    Created on : 25/06/2018, 14:48:04
    Author     : PauloHGama
--%>

<%@page import="br.com.fatecpg.motorwebapp.web.Clientes"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Carros"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    String nome = "";
    String cpf = "";
    String tel = "";
    long id = 0;
    if(request.getParameter("formDeletar") != null)
    {
        id = Long.parseLong(request.getParameter("id"));
        try
        {
            Clientes.delClientes(id);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    if(request.getParameter("formAlterar") != null)
    {
        Clientes c = Clientes.getClientesAlterar(Long.parseLong(request.getParameter("id")));
        id = c.getId();
        nome = c.getNome();
        cpf = c.getCpf();
        tel = c.getTel();
    }
    if(request.getParameter("formNewCliente") != null)
    {
        nome = request.getParameter("nome");
        cpf = request.getParameter("cpf");
        tel = request.getParameter("tel");
        try
        {
            Clientes.addClientes(cpf, nome, tel);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    if(request.getParameter("executaAlterar") != null)
    {
        nome = request.getParameter("nome");
        cpf = request.getParameter("cpf");
        tel = request.getParameter("tel");
        id = Long.parseLong(request.getParameter("id"));
        try
        {
            Clientes.altClientes(cpf, nome, tel, id);
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
        <h1 class="text-center mx-auto display-4">Clientes</h1>
        <%if(session.getAttribute("user") == null){%>
            <h2 style="color: red">TU NÃO TA LOGADO NÃO MERMÃO</h2>
        <%}else{%>
            <% 
            if(error!=null) out.print("<h2>" + error + "</h2>");%>
            <% if(request.getParameter("formAlterar") == null) {%>
            <div class="container-fluid border border-success mx-center text-center">
            <fieldset>
            <legend>Novo Cliente</legend>
                <form>
                    <table class="text-center mx-auto">
                        <tr><td><label for="nome">Nome </label></td><td><input type="text" name="nome" id="nome" required/></td></tr>
                        <tr><td><label for="cpf">CPF </label></td><td><input type="text" name="cpf" maxlength="11" id="cpf" required/></td></tr>
                    <tr><td><label for="tel">Telefone </label></td><td><input type="text" name="tel"  maxlength="11" id="tel" required/></td></tr>
                    <tr align="right"><td colspan="2"><input type="submit" name="formNewCliente" value="Adicionar" class="btn btn-success"/></td></tr>
                    </table>
                </form>
            </fieldset>
            </div>
                <br/>
            <hr/>
            <%} else {%>
            <div class="container-fluid border border-success mx-center text-center">
            <fieldset>
                <legend>Alterar Cliente: <%= nome %></legend>
                <form>
                    <table class="text-center mx-auto">
                        <tr><td><label for="nomee">Nome </label></td><td><input type="text" name="nome" value="<%= nome %>" id="nomee" required/></td></tr>
                        <tr><td><label for="cpfe">CPF </label></td><td><input type="text" name="cpf" value="<%= cpf %>" id="cpfee" required/></td></tr>
                        <tr><td><label for="tele">Telefone </label></td><td><input type="text" name="tel" value="<%= tel %>" id="tele" required/>
                                <input type="hidden" name="id" value="<%=id%>"></td></tr>
                        
                        <tr align="right"><td colspan="2"><input type="submit" name="executaAlterar" value="Alterar" class="btn btn-success"/></td></tr>
                    </table>
                </form>
            </fieldset>
            </div>
            <hr/>
            <%}%>
            <div class="container-fluid border border-success mx-center text-center">
                <br/>
            <table border="1" class="mx-auto text-center">
                <tr>
                    <th>ID</th>
                    <th>NOME</th>
                    <th>CPF</th>
                    <th>TEL</th>
                    <th colspan="2">Ações</th>
                </tr>
                <%try {
                    for(Clientes c: Clientes.getClientes()){
                    %>
                    <tr>
                        <td><%= c.getId()%></td>
                        <td><%= c.getNome()%></td>
                        <td><%= c.getCpf()%></td>
                        <td><%= c.getTel() %></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar" class="btn btn-danger">
                            </form></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                <input type="submit" name="formAlterar" value="Alterar" class="btn btn-warning">
                        </form></td>
                    </tr>
                <%}} catch(Exception ex){} %>
            </table>
            <%}%>
            <br/>
            </div>
    </body>
</html>
