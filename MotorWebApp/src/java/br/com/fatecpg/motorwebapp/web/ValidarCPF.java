package br.com.fatecpg.motorwebapp.web;

/**
 *
 * @author PauloHGama
 */
public class ValidarCPF {
    public static boolean CPFVALIDADO(String cpf)
    {   
    int[] multiplicador1 = new int[] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
    int[] multiplicador2 = new int[] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
    String tempCpf;
    String digito;
    int soma;
    int resto;
    cpf = cpf.trim();
    cpf = cpf.replace(".", "").replace("-", "");
    if (cpf.length() != 11)
        return false;
    tempCpf = cpf.substring(0, 9);
    soma = 0;

    for (int i = 0; i < 9; i++)
        soma += Integer.parseInt(tempCpf.substring(i , i+1)) * multiplicador1[i];
    resto = soma % 11;
    if (resto < 2)
        resto = 0;
    else
        resto = 11 - resto;
    digito =  resto + "";
    tempCpf = tempCpf + digito;
    soma = 0;
    for (int i = 0; i < 10; i++)
        soma += Integer.parseInt(tempCpf.substring(i , i+1)) * multiplicador2[i];
    resto = soma % 11;
    if (resto < 2)
        resto = 0;
    else
        resto = 11 - resto;
    digito =(String) digito + resto;
    return cpf.endsWith(digito);
}
}
