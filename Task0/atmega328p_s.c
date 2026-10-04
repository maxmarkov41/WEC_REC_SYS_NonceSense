extern int main(void);


void isr_reset(void){
    main();

    while(1);
}

void isr_hardfault(void){
    while(1);
}