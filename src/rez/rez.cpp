#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main(int ac, char *av[]) {
  char *line = nullptr;
  size_t len = 0; 
  ssize_t nread;

  FILE *out = popen("xrandr", "r");
 
  while ((nread = getline(&line, &len, out)) != -1) {
    line[nread-1] = '\0';
    char *ptr = line;
    while (*ptr != '\0' && isspace(*ptr)) *ptr++;
    int width = 0;
    if (*ptr >= '0' && *ptr <= '9') {
      char *end = ptr;
      while (isdigit(*end) && *end != '\0') {
        width = width * 10 + (*end - '0');
        end++;
      }
      while (!isspace(*end) && *end != '\0') {
        end++;
      }
      if (width >= 1024) {
        char *mode = strndup(ptr, end-ptr);
        printf("%s\n", mode);
//        printf("%d %s\n", width, mode);
        free(mode);
      }
    }
//    printf("%5d %5d %s\n", len, nread, line);
  } 
  return 0;
}
