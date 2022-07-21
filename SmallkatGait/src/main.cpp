#include <Arduino.h>
#include <ESP32Servo.h>
#include <Adafruit_Sensor.h>


/*
define Limb servo pin numbers
*/
#define RL_basepan 2
#define RL_basetilt 4
#define RL_elbow 15

#define FR_basepan 5
#define FR_basetilt 17
#define FR_elbow 16

#define FL_basepan 23
#define FL_basetilt 19
#define FL_elbow 32

#define RR_basepan 13
#define RR_basetilt 12
#define RR_elbow 14

#define Head_basepan 27
#define Head_basetilt 26

#define Tail_basepan 33
#define Tail_basetilt 25

int minUs = 1000;
int maxUs = 2000;

// create our 16 servo objects
Servo servoRL_BP;
Servo servoRL_BT;
Servo servoRL_EB;
Servo servoFR_BP;
Servo servoFR_BT;
Servo servoFR_EB;
Servo servoFL_BP;
Servo servoFL_BT;
Servo servoFL_EB;
Servo servoRR_BP;
Servo servoRR_BT;
Servo servoRR_EB;
Servo servoH_BP;
Servo servoH_BT;
Servo servoT_BP;
Servo servoT_BT;

struct leg_vals{
  int BasePan;
  int BaseTilt;
  int Elbow;
};
long int lasttime;
int step_counter;
int leg;

void setup() {
  // for barebones gait motion, we'll ignore sensor feedback, and initialize all servos induvidually
  // setup ESP32 timers
ESP32PWM::allocateTimer(0);
ESP32PWM::allocateTimer(1);
ESP32PWM::allocateTimer(2);
ESP32PWM::allocateTimer(3);
ESP32PWM::allocateTimer(4);
ESP32PWM::allocateTimer(5);
ESP32PWM::allocateTimer(6);
ESP32PWM::allocateTimer(7);
ESP32PWM::allocateTimer(8);
ESP32PWM::allocateTimer(9);
ESP32PWM::allocateTimer(10);
ESP32PWM::allocateTimer(11);
ESP32PWM::allocateTimer(12);
ESP32PWM::allocateTimer(13);
ESP32PWM::allocateTimer(14);
ESP32PWM::allocateTimer(15);
Serial.begin(115200);
servoRL_BP.attach(RL_basepan, minUs,maxUs);
servoRL_BT.attach(RL_basetilt, minUs,maxUs);
servoRL_EB.attach(RL_elbow, minUs,maxUs);

servoFL_BP.attach(FL_basepan, minUs,maxUs);
servoFL_BT.attach(FL_basetilt,minUs,maxUs);
servoFL_BP.attach(FL_elbow, minUs,maxUs);

servoRR_BP.attach(RR_basepan, minUs,maxUs);
servoRR_BT.attach(RR_basetilt,minUs,maxUs);
servoRR_BP.attach(RR_elbow, minUs,maxUs);

servoFR_BP.attach(FR_basepan, minUs,maxUs);
servoFR_BT.attach(FR_basetilt,minUs,maxUs);
servoFR_BP.attach(FR_elbow, minUs,maxUs);

servoH_BP.attach(Head_basepan,minUs,maxUs);
servoH_BT.attach(Head_basetilt,minUs,maxUs);

servoT_BP.attach(Tail_basepan,minUs,maxUs);
servoT_BT.attach(Tail_basetilt,minUs,maxUs);

// stand up the robot

int basepan_home = 100;
int basetilt_home = 45;
int elbow_home = 45;
int head_home = 90;
int head_tilt_home =90;
int tail_home = 90;
int tail_tilt_home = 90; 
//initalize Rear Left leg
servoRL_BP.write(basepan_home);
servoRL_BT.write(basetilt_home);
servoRL_EB.write(elbow_home);

servoFL_BP.write(basepan_home);
servoFL_BT.write(basetilt_home);
servoFL_BP.write(elbow_home);

servoRR_BP.write(50);
servoRR_BT.write(90);
servoRR_BP.write(100);

servoFR_BP.write(basepan_home);
servoFR_BT.write(basetilt_home);
servoFR_BP.write(elbow_home);

servoH_BP.write(head_home);
servoH_BT.write(head_tilt_home);

servoT_BP.write(tail_home);
servoT_BT.write(tail_tilt_home);
lasttime = esp_timer_get_time();
step_counter = 0;
leg = 1;

}

void loop() {
  // put your main code here, to run repeatedly:
  // run walk cycle
  // how long does a single cycle take?
  int cycle_time = 100; 
  long int currtime = esp_timer_get_time();
  Serial.println(currtime%cycle_time);

  int BasePan[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  int BaseTilt[] = {31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,32,32,32,32,32,32,33,33,33,34,34,34,35,35,35,36,36,36,37,37,37,37,38,38,38,38,38,38,38,37,37,37,36,36,35,35,34,33,32,32,31,30,29,28,27,26,25,23,22,21,20,19,18,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,1,0,0,0,1,1,2,2,3,3,3,3,4,4,4,4,4};
  int Elbow[] = {13,13,13,13,13,13,13,13,14,14,14,15,15,16,16,17,18,18,19,20,21,22,23,25,26,27,29,30,32,33,35,36,38,39,41,42,44,45,46,48,49,50,51,52,52,53,53,54,54,54,54,53,53,53,52,51,50,49,48,47,46,44,43,41,39,38,36,34,32,31,29,27,25,24,22,20,18,17,15,14,12,11,10,9,8,7,6,5,4,3,3,2,2,2,1,1,1,1,1,1};

   // run a command every 500milliseconds
   int cmd_interval = 3000;
   if(currtime-lasttime > cmd_interval){
    switch (leg)
    {
    case 1:
    servoFR_BT.write(BaseTilt[step_counter]+90);
    servoFR_BP.write(Elbow[step_counter]);
    
      break;
    case 2:
    servoFL_BT.write(BaseTilt[step_counter]+90);
    servoFL_BP.write(Elbow[step_counter]);
    break;

    case 3:
    servoRR_BT.write(BaseTilt[step_counter]+90);
    servoRR_BP.write(Elbow[step_counter]);
    break;

    case 4:
    servoRL_BT.write(BaseTilt[step_counter]+90);
    servoRL_BP.write(Elbow[step_counter]);
    break;

    default:
      break;
    }
  //  servoRR_BT.write(BaseTilt[step_counter]+90);
  //  servoRR_BP.write(Elbow[step_counter]);
   step_counter++;
   if(step_counter>99){
    step_counter = 0;
    leg++;
   }
   }

   

  lasttime = currtime;
}

