MEMORY
{
    RAM : ORIGIN = 0X8000000, LENGTH = 4K
}

SECTIONS
{
.text : {
    *(.text*)
    } > RAM
}
