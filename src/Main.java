package analizador;

import java.io.*;

public class Main {
    public static void main(String[] args) {
        String inputFilePath = "src/entrada.html";
        String outputFilePath = "output/tokens.txt";
        
        try {
            // Asegurarnos de que la carpeta de salida existe
            File outputDir = new File("output");
            if (!outputDir.exists()) {
                outputDir.mkdirs();
            }
            
            // Leer el archivo de entrada
            Reader reader = new FileReader(inputFilePath);
            
            // Preparar el archivo de salida
            Writer writer = new FileWriter(outputFilePath);
            
            // Crear e inicializar el lexer
            HTMLLexer lexer = new HTMLLexer(reader);
            lexer.setWriter(writer);
            
            // Comenzar el análisis léxico
            while (!lexer.isDone()) {
                lexer.yylex();
            }
            
            // Cerrar archivos
            writer.close();
            reader.close();
            
            System.out.println("Análisis léxico completado. Resultados en: " + outputFilePath);
            
        } catch (Exception e) {
            System.err.println("Error durante el análisis léxico: " + e.getMessage());
            e.printStackTrace();
        }
    }
}