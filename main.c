#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#define BUFFER_SIZE 1024
void print_help() {
    printf("Usage: cutline [-h | --help] [-v | --version] ...\n");
    printf("    Cut lines to 30 characters.\n\n");
    printf("Options:\n");
    printf("    -h, --help \n");
    printf("        display this help and exit\n");
    printf("    -v, --version\n");
    printf("        output version information and exit\n");
}

void print_version() {
    printf("cutline version: 0.0.1 %s\n");
}

void cutline_file(FILE *file) {
    char buffer[BUFFER_SIZE];
    
    while (fgets(buffer, sizeof(buffer), file)) {
        // Удаляем символ новой строки
        size_t len = strlen(buffer);
        if (len > 0 && buffer[len - 1] == '\n') {
            buffer[len - 1] = '\0';
            len--;
        }
        
        // Обрезаем строку до 30 символов
        if (len > 30) {
            buffer[30] = '\0';
        }
        
        printf("%s\n", buffer);
    }
}

int main(int argc, char *argv[])
{
    int opt;
    
    struct option long_options[] = {
        {"help", no_argument, 0, 'h'},
        {"version", no_argument, 0, 'v'},
        {0, 0, 0, 0}
    };
    
    // Обработка опций
    while ((opt = getopt_long(argc, argv, "hv", long_options, NULL)) != -1) {
        switch (opt) {
            case 'h':
                print_help();
                break;
            case 'v':
                 print_version();
                break;
            default:
                fprintf(stderr, "Try 'cutline --help' for more information.\n");
                return 1;
        }
    }
    
    
    // Если есть аргументы файлов
    if (optind < argc) {
        for (int i = optind; i < argc; i++) {
            FILE *file = fopen(argv[i], "r");
            if (file == NULL) {
                fprintf(stderr, "cutline: cannot open file '%s'\n", argv[i]);
                continue;
            }
            
            cutline_file(file);
            fclose(file);
        }
    } else {
        // Чтение из stdin
        cutline_file(stdin);
    }
    
    return 0;
}
