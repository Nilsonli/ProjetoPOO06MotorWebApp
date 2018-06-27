<%-- 
    Document   : consertos
    Created on : 25/06/2018, 21:44:39
    Author     : PauloHGama
--%>

<%@page import="br.com.fatecpg.motorwebapp.web.Carros"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Mecanico"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Clientes"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="br.com.fatecpg.motorwebapp.web.Consertos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String error = null;
    String nomepeca="";
    double preco =0;
    long altidc = 0,altidc2=0;
    int cm = 0, cp=1;
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
        preco = Double.parseDouble(request.getParameter("preco"));
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
        
        if(request.getParameter("formAlterar") != null)
    {
        long idc;
        altidc = Long.parseLong(request.getParameter("id"));
        for(Consertos u: Consertos.getConsertos()){
            idc = u.getId();
            if(idc == altidc){
            cm = u.getMecanico();
            nomepeca = u.getPeca();
            preco = u.getPreco();
            cp = u.getPlaca();
            }
        }

    }
        
        if(request.getParameter("alterarConserto") != null){
        int placa = Integer.parseInt(request.getParameter("altplaca"));
        int mecanico = Integer.parseInt(request.getParameter("altmecanico"));
        String peca = request.getParameter("altpeca");
        preco = Double.parseDouble(request.getParameter("altpreco"));

        try
        {
            altidc2 = Long.parseLong(request.getParameter("idalt"));
            Consertos.altConsertos(placa,mecanico,peca,preco,altidc2);
            response.sendRedirect(request.getRequestURI());
        }
        catch(Exception ex)
        {
            error = ex.getMessage();
        }}
        
        if(request.getParameter("resetFormalt")!=null){
        response.sendRedirect(request.getRequestURI());
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
        <title>Agenda de Consertos</title>
    </head>
    <body ng-app="ngAnimate">
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <div>
        <h1 class="display-4 text-center">Consertos</h1>
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
                <legend>Cadastrar Conserto</legend>
                <form>
                    Carro <select name="placa" id="placa" required>
                        <% try{ for(Carros c: Carros.getCarros()){%>
                        <option value="<%= c.getId()%>"><%= c.getMarca()+'/'+c.getModelo()+'/'+ c.getPlaca() %></option>
                        <%}}catch(Exception ex){%><option value="null" disabled>Não há Carros</option><%}%>
                    </select>
                    Mecanico <select name="mecanico" id="mecanico">
                        <% try{ for(Mecanico m: Mecanico.getMecanico()){%>
                        <option value="<%= m.getId()%>"><%= m.getNome() %></option>
                        <%}}catch(Exception ex){%><option value="null" disabled>Não há Mecanicos</option><%}%>
                    </select>
                    Peça Utilizada <input type="text" name="peca" id="peca" required>
                    Valor do conserto <input type="number" name="preco" step="0.1" id="preco" required>
                    <input type="submit" name="addNewConserto" value="Confirmar" class="btn btn-success">
                    <input type="reset" name="resetForm" value="Cancelar" class="btn btn-danger">
                </form>
            </fieldset>
                    <br/>
            </div>
                        <%if(request.getParameter("formAlterar")!=null){%>
                        <br/>
           <div class="container-fluid border border-warning text-center mx-auto">
            <fieldset>
                <legend>Alterar Conserto</legend>
                <form>
                    Carro <select name="altplaca" id="altplaca" required>
                        <% try{ for(Carros c: Carros.getCarros()){%>
                        <% if(cp == c.getId()){%>
                        <option selected="" value="<%= c.getId()%>"><%= c.getMarca()+'/'+c.getModelo()+'/'+ c.getPlaca() %></option>
                        <%}else{%>
                        <option value="<%= c.getId()%>"><%= c.getMarca()+'/'+c.getModelo()+'/'+ c.getPlaca() %><%}%></option>
                        <%}}catch(Exception ex){%><option value="null" disabled>Não há Carros</option><%}%>
                    </select>
                    Mecanico <select name="altmecanico" id="altmecanico">
                        <% try{ for(Mecanico m: Mecanico.getMecanico()){%>
                        <% if(cm == m.getId()){%>
                        <option selected="" value="<%= m.getId()%>"><%= m.getNome()%></option>
                        <%}else{%>
                        <option value="<%= m.getId()%>"><%= m.getNome() %><%}%></option>
                        <%}}catch(Exception ex){%><option value="null" disabled>Não há Mecanicos</option><%}%>
                    </select>
                    Peça Utilizada <input type="text" name="altpeca" id="altpeca" value="<%= nomepeca %>" required>
                    Valor do conserto <input type="number" name="altpreco" step="0.1" id="altpreco" value="<%= preco %>" required>
                                      <input type="hidden" name="idalt" value="<%= altidc %>"/>
                    <input type="submit" name="alterarConserto" value="Confirmar" class="btn btn-success">
                    <input type="submit" name="resetFormalt" value="Cancelar" class="btn btn-danger">
                </form>
            </fieldset>
                    <br/>
                    </div>
                    <%}%>
        </div>
                    
<br/>
            <div class="border border-primary text-center mx-auto">
<br/>
            <table class="mx-auto text-center" border="2">
                <tr>

                    <th>Nome Cliente</th>
                    <th>Placa</th>
                    <th>Modelo</th>
                    <th>Marca</th>
                    <th>Mecanico</th>
                    <th>Peça</th>
                    <th>Preço</th>
                </tr>
                <% try{ for(Consertos u: Consertos.getConsertos()){long idcli=0;String nome="";String placa="";String modelo="";String marca="";String nomecli="";%>
               <tr>
                   <%for(Mecanico m: Mecanico.getMecanico()){
                        if (m.getId() == u.getMecanico()){
                            nome = m.getNome();
                        }
                   }
                    for(Carros c: Carros.getCarros()){
                        if (c.getId() == u.getPlaca()){
                            placa = c.getPlaca();
                            modelo= c.getModelo();
                            marca= c.getMarca();
                            idcli = c.getCliente();
                        }}
                   for(Clientes cli: Clientes.getClientes()){
                   if (cli.getId() == idcli){
                            nomecli = cli.getNome();
                   }
                   }

%>
                    <td><%=nomecli %></td>
                    <td><%=placa %></td>
                    <td><%=modelo %></td>
                    <td><%=marca %></td>
                    <td><%=nome %></td>
                    <td><%= u.getPeca() %></td>
                    <td><%= u.getPreco() %>0</td>
                    <td><form>
                        <input type="hidden" name="id" value="<%= u.getId() %>"/>
                        <input type="submit" name="formDeletar" value="Deletar" class="btn btn-danger">
                    </form></td>
                    <td><form>
                        <input type="hidden" name="id" value="<%= u.getId() %>"/>
                        <input type="submit" name="formAlterar" value="Alterar" class="btn btn-warning">
                    </form>
                        
                    </td>
                </tr>
                <%}}catch(Exception ex){}%>
            </table>
<br/>
            </div>
            <%}}%>
    </body>
</html>
