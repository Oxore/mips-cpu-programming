volatile int iterator = 0;
volatile int decrement = 0;

__attribute__((used, section("._start"))) void _start(void)
{
    for (;;) {
        iterator += decrement ? -1 : 1;
        if (iterator >= 3) {
            decrement = 1;
        } else if (iterator <= 0) {
            decrement = 0;
        }
    }
}
