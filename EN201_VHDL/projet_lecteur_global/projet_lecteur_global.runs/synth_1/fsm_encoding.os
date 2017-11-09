
 add_fsm_encoding \
       {fsm_mp3.curr_state} \
       { }  \
       {{000 000} {001 001} {010 100} {011 010} {100 011} }

 add_fsm_encoding \
       {UART_recv.state} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} {101 101} {110 110} }
