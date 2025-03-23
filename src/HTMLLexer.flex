//Miguel Andres Monroy Najera
//Carne: 202302407
//Analizador lexic HTML

package analizador;

import java.io.*;

%%

%class HTMLLexer
%public
%unicode
%line
%column
%type TokenHTML

%{
  private StringBuilder sb = new StringBuilder();
  private Writer writer;
  private boolean done = false;
  
  public void setWriter(Writer writer) {
    this.writer = writer;
  }
  
  public boolean isDone() {
    return done;
  }
  
  private void emitToken(String tipo, String lexema) {
    try {
      writer.write("Token: " + tipo + ", Lexema: \"" + lexema + "\", Línea: " + (yyline + 1) + ", Columna: " + (yycolumn + 1) + "\n");
      writer.flush();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  public enum TokenHTML {
    DOCTYPE, ETIQUETA_APERTURA, ETIQUETA_CIERRE, NOMBRE_ATRIBUTO, 
    VALOR_ATRIBUTO, TEXTO, COMENTARIO, ENTIDAD_HTML, ERROR
  }
%}

/* Macros */
Espacio        = [ \t\r\n\f]
DocType        = "<!DOCTYPE"[^>]*">"
EtiqApertura   = "<"[a-zA-Z][a-zA-Z0-9]*
EtiqCierre     = "</"[a-zA-Z][a-zA-Z0-9]*">"
NombreAtributo = [a-zA-Z][a-zA-Z0-9\-]*
ValorAtributo  = \"[^\"]*\"
Entidad        = "&"[a-zA-Z]+";"|"&#"[0-9]+";"|"&"[#a-zA-Z0-9]+";"|"&lt;"|"&gt;"|"&amp;"|"&quot;"|"&apos;"
InicioComentario = "<!--"
FinComentario  = "-->"

%state COMENTARIO, EN_ETIQUETA, EN_TEXTO

%%

/* Reglas léxicas */
<YYINITIAL> {
  {DocType}        { emitToken("DOCTYPE", yytext()); }
  {EtiqApertura}   { emitToken("ETIQUETA_APERTURA", yytext()); yybegin(EN_ETIQUETA); }
  {EtiqCierre}     { emitToken("ETIQUETA_CIERRE", yytext()); }
  {InicioComentario} { sb.setLength(0); sb.append(yytext()); yybegin(COMENTARIO); }
  {Espacio}        { /* ignorar espacios */ }
  .                { yybegin(EN_TEXTO); yypushback(1); }
  <<EOF>>          { done = true; return TokenHTML.ERROR; }
}

<EN_ETIQUETA> {
  {NombreAtributo}"=" { emitToken("NOMBRE_ATRIBUTO", yytext()); }
  {ValorAtributo}    { emitToken("VALOR_ATRIBUTO", yytext()); }
  ">"                { emitToken("CIERRE_ETIQUETA", yytext()); yybegin(YYINITIAL); }
  "/>"               { emitToken("CIERRE_ETIQUETA_AUTOCIERRE", yytext()); yybegin(YYINITIAL); }
  {Espacio}         { /* ignorar espacios */ }
  <<EOF>>           { done = true; return TokenHTML.ERROR; }
}

<EN_TEXTO> {
  "<"                { yypushback(1); yybegin(YYINITIAL); }
  {Entidad}          { emitToken("ENTIDAD_HTML", yytext()); }
  [^<&\n]+           { emitToken("TEXTO", yytext()); }
  \n                 { emitToken("TEXTO", yytext()); }
  "&"                { emitToken("TEXTO", yytext()); }
  <<EOF>>            { done = true; return TokenHTML.ERROR; }
}

<COMENTARIO> {
  {FinComentario}    { sb.append(yytext()); emitToken("COMENTARIO", sb.toString()); yybegin(YYINITIAL); }
  [^-]+              { sb.append(yytext()); }
  "-"                { sb.append(yytext()); }
  <<EOF>>            { done = true; return TokenHTML.ERROR; }
}

/* Error handling */
[^]                  { emitToken("ERROR", yytext()); }