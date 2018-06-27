<%-- 
    Document   : mecanicos
    Created on : 25/06/2018, 21:44:55
    Author     : PauloHGama e Nilsonli
--%>

<%@page import="br.com.fatecpg.motorwebapp.web.ValidarCPF"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Mecanico"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<% 
    String error = null;
    String cpf = "";
    String nome = "";
    long id = 0;
    if(request.getParameter("formDeletar") != null)
    {
        id = Long.parseLong(request.getParameter("id"));
        try
        {
            Mecanico.delMecanico(id);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }
    }
    if(request.getParameter("formAlterar") != null)
    {
        Mecanico m = Mecanico.getMecanicoAlterar(Long.parseLong(request.getParameter("id")));
        id = m.getId();
        cpf = m.getCpf();
        nome = m.getNome();
    }
    if(request.getParameter("formNewMecanic") != null)
    {
        cpf = request.getParameter("cpf");
        nome = request.getParameter("nome");
        if(ValidarCPF.CPFVALIDADO(cpf)){
            try
            {
                Mecanico.addMecanico(cpf, nome);
                response.sendRedirect(request.getRequestURI());
            }
            catch(Exception ex)
            {
                error = ex.getMessage();
            }
        }
        else
        {
            error = "CPF INVALIDO";
        }
    }
    if(request.getParameter("executaAlterar") != null)
    {
        cpf = request.getParameter("cpf");
        nome = request.getParameter("nome");
        id = Long.parseLong(request.getParameter("id"));
        try
        {
            Mecanico.altMecanico(cpf, nome,id);
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
        <title>Mecanicos</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1 class="text-center mx-auto display-4">Mecanicos</h1>
        <%if(session.getAttribute("user") == null){%>
            <h2 style="color: red">TU NÃO TA LOGADO NÃO MERMÃO</h2>
        <%}else{%>
            <% 
            User user = (User) session.getAttribute("user");
            if(!user.getRole().equals("ADMIN"))
            {
                out.print("<h2 style='color: red'>TU NEM É ADMIN MANO, SAI DAQUI</h2>");
            }
            else { if(error!=null) out.print("<h2 style='color: red'>" + error + "</h2>");%>
             <% if(request.getParameter("formAlterar") == null) {%>
             <div class="container-fluid border border-success mx-center text-center">
            <fieldset>
            <legend>Novo Mecanico</legend>
                <form>
                    <table class="text-center mx-auto">
                        <tr><td><label for="cpf">Cpf </label></td><td><input type="number" name="cpf" maxlength="11" id="cpf" required/></td></tr>
                    <tr><td><label for="nome">Nome </label></td><td><input type="text" name="nome" id="nome" required/></td></tr>
                    <tr align="right"><td colspan="2"><input type="submit" name="formNewMecanic" value="Adicionar" class="btn btn-success"/></td></tr>
                    </table>
                </form>
            </fieldset>
             </div>
            <hr/>
            <%} else {%>
            <div class="container-fluid border border-success mx-center text-center">
            <fieldset>
                <legend>Alterar Nome de Mecanico de Cpf nº: <%= cpf %></legend>
                <form>
                    <table>
                                              
                        <tr><td><label for="cpfe">Cpf </label></td><td><input type="number" name="cpf" maxlength="11" value="<%= Integer.parseInt(cpf) %>" id="cpfe" required/></td></tr>
                        <tr><td><label for="nomee">Nome </label></td><td><input type="text" name="nome" value="<%= nome %>" id="nomee" required/></td></tr>
                        <tr><td><input type="hidden" name="id" value="<%= id %>">
                     </td></tr>
                        <tr align="right"><td colspan="2"><input type="submit" name="executaAlterar" value="Alterar" clas="btn btn-success"/></td></tr>
                    </table>
                </form>
            </fieldset>
            </div>
            <hr/>
            <%}%>
            <div class="container-fluid border border-success mx-center text-center">
            <table border="1" class="mx-auto text-center">
                <tr>
                    <th>ID</th>
                    <th>CPF</th>
                    <th>NOME</th>
                   <th colspan="2">Ações</th>
                </tr>
                <%try{
                for(Mecanico m: Mecanico.getMecanico()){ %>
                    <tr>
         |              <td><%= m.getId()%></td>
                        <td><%= m.getCpf() %></td>
                        <td><%= m.getNome() %></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= m.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar" class="btn btn-danger">                                
                  </form></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= m.getId() %>"/>
                                <input type="submit" name="formAlterar" value="Alterar" class="btn btn-warning">
                        </form></td>
                    </tr>
                    <%}}catch(Exception ex){}%>
                
            </table>
           
            <%}}%>
            <br/>
            </div>
    </body>
</html>
