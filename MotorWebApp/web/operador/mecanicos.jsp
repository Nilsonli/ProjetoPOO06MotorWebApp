<%-- 
    Document   : mecanicos
    Created on : 25/06/2018, 21:44:55
    Author     : PauloHGama e Nilsonli
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Carros"%>
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
        Mecanico m = mecanico.getMecanicoAlterar(Long.parseLong(request.getParameter("id")));
        id = m.getId();
        cpf = m.getCpf();
        nome = m.getNome();
    }
    if(request.getParameter("formNewCar") != null)
    {
        cpf = request.getParameter("cpf");
        nome = request.getParameter("nome");
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
        <title>Mecanicos</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Mecanicos</h1>
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
             <% if(request.getParameter("formAlterar") == null) {%>
            <fieldset>
            <legend>Novo Mecanico</legend>
                <form>
                    <table>
                        <tr><td><label for="cpf">Cpf </label></td><td><input type="text" name="cpf" id="cpf" required/></td></tr>
                    <tr><td><label for="nome">Nome </label></td><td><input type="text" name="nome" id="nome" required/></td></tr>
               
                        <% ArrayList<Object[]> o = Mecanico.getMecanicos(0);
                            for(int i = 0; i < o.size(); i++){
                            Object[] ob = o.get(i);  %>
                            <option value="<%= (long) ob[0] %>"><%= (String) ob[1] %></option >
                            <%}%>
                            </select></td></tr>
                    <tr align="right"><td colspan="2"><input type="submit" name="formNewMecanic" value="Adicionar"/></td></tr>
                    </table>
                </form>
            </fieldset>
            <hr/>
            <%} else {%>
            <fieldset>
                <legend>Alterar Nome de Mecanico de Cpf nº: <%= cpf %></legend>
                <form>
                    <table>
                                              
                        <tr><td><label for="cpfe">Cpf </label></td><td><input type="text" name="cpf" value="<%= cpf %>" id="cpfe" required/></td></tr>
                        <tr><td><label for="nomee">Nome </label></td><td><input type="text" name="nome" value="<%= nome %>" id="nomee" required/></td></tr>
                        <tr><td><input type="hidden" name="id" value="<%= id %>">
                     </td></tr>
                        <tr align="right"><td colspan="2"><input type="submit" name="executaAlterar" value="Alterar"/></td></tr>
                    </table>
                </form>
            </fieldset>
            <hr/>
            <%}%>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>CPF</th>
                    <th>NOME</th>
                    <th colspan="2">Ações</th>
                </tr>
                <%for(Mecanico m: Mecanico.getMecanicos()){ %>
                    <tr>
                        <% ArrayList<Object[]> um = Mecanico.getMecanicos(m.getId());
                            Object[] ob = um.get(0);  %>
                        <td><%= m.getId()%></td>
                        <td><%= m.getCpf() %></td>
                        <td><%= m.getNome() %></td>
                        <td><%= (String) ob[1] %></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= m.getId() %>"/>
                                <input type="submit" name="formDeletar" value="Deletar">
                            </form></td>
                        <td><form>
                                <input type="hidden" name="id" value="<%= m.getId() %>"/>
                                <input type="submit" name="formAlterar" value="Alterar">
                        </form></td>
                    </tr>
                <%}%>
            </table>
            <%}%>
            <%}}%>
    </body>
</html>
