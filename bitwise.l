/* Scanner implementation using Flex */
/* Functionality:
	* 1. Simple language for bitwise operations between hex or binary numbers.
	* 2. Operations included in this language are NOT,AND,OR,NAND,XOR,represented by the operators !, *, +, &, #, respectively.
	* 3. Includes an assignment instruction.
	* 4. A binary is a sequence of 8 binary digits.
	* 5. A hexadecimal starts with 0X or 0x followed by hex digits. Includes a-f and A-F.
	* 6. An identifier is a sequence of letters, digits and underscores that start with a letter.
	* 7. Includes a instruction block between this {}  
*/

%{
#include <stdlib.h>
#include "bitwise.tab.h"
%}

%%
"bin" {return(bin); }
"hex" {return(hex); }
[!*+&#] {return(yytext[0]);}
0[xX][0-9a-fA-F]+ {return(hexconst);}
[0,1]{8} {return(binconst);}
[_a-zA-Z][_a-zA-Z0-9]+ {return(identifier);}
[[:space:]] { /* DO NOTHING: blank spaces are ignored. */}
"/".*	{ /* DO NOTHING: single -line comments are ignored. */}
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* DO NOTHING: multi - line commments are ignored */ }
.	{  }
%%
