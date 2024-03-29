# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lruiz-es <lruiz-es@student.42barcel>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/03/03 08:41:31 by lruiz-es          #+#    #+#              #
#    Updated: 2024/03/23 16:00:49 by lruiz-es         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

cc gentest.c -o gentest.out
if ! [ -d test_output_files ]; then mkdir test_output_files; fi
./gentest.out > test_output_files/output
make re
if ! [ -d user_output ]; then mkdir user_output; fi
cc -g -Wall -Werror -Wextra main.c libftprintf.a
mv a.out x_to_leaks
cc -g -fsanitize=address -Wall -Werror -Wextra main.c libftprintf.a
echo "++++++++++++++Informe de ejecucion++++++++++++++++++++++++++"
echo "Se imprimiran los errores de gestion de memoria, si los hubiere"
./a.out > user_output/output
echo 
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++Informe de errores de diferencias al+++++++++++++++"
echo "+++++++++++++comportamiento esperado++++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
diff test_output_files/output user_output/output 
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "++++++++++++Se imprimira informacion de LEAKS+++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
leaks -atExit -- ./x_to_leaks
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ++++++++++++++++++FIN DEL INFORME DE EJECUCION+++++++++++++++
