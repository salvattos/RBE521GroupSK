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
  int theta_1
  int theta_2
  int theta_3
}
int lasttime;
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
// servoRL_BP.attach(RL_basepan, minUs,maxUs);
// servoRL_BT.attach(RL_basetilt, minUs,maxUs);
// servoRL_EB.attach(RL_elbow, minUs,maxUs);

// servoFL_BP.attach(FL_basepan, minUs,maxUs);
// servoFL_BT.attach(FL_basetilt,minUs,maxUs);
// servoFL_BP.attach(FL_elbow, minUs,maxUs);

servoRR_BP.attach(RR_basepan, minUs,maxUs);
servoRR_BT.attach(RR_basetilt,minUs,maxUs);
servoRR_BP.attach(RR_elbow, minUs,maxUs);

// servoFR_BP.attach(FR_basepan, minUs,maxUs);
// servoFR_BT.attach(FR_basetilt,minUs,maxUs);
// servoFR_BP.attach(FR_elbow, minUs,maxUs);

// servoH_BP.attach(Head_basepan,minUs,maxUs);
// servoH_BT.attach(Head_basetilt,minUs,maxUs);

// servoT_BP.attach(Tail_basepan,minUs,maxUs);
servoT_BT.attach(Tail_basetilt,minUs,maxUs);

// stand up the robot

int basepan_home = 100;
int basetilt_home = 45;
int elbow_home = 45;
int head_home = 90;
int head_tilt_home =90;
int tail_home = 90;
int tail_tilt_home = 90; 
// initalize Rear Left leg
// servoRL_BP.write(basepan_home);
// servoRL_BT.write(basetilt_home);
// servoRL_EB.write(elbow_home);

// servoFL_BP.write(basepan_home);
// servoFL_BT.write(basetilt_home);
// servoFL_BP.write(elbow_home);

servoRR_BP.write(50);
servoRR_BT.write(90);
servoRR_BP.write(100);

// servoFR_BP.write(basepan_home);
// servoFR_BT.write(basetilt_home);
// servoFR_BP.write(elbow_home);

// servoH_BP.write(head_home);
// servoH_BT.write(head_tilt_home);

// servoT_BP.write(tail_home);
// servoT_BT.write(tail_tilt_home);
lasttime = esp_timer_get_time();
}

void loop() {
  // put your main code here, to run repeatedly:
  // run walk cycle
  // how long does a single cycle take?
  int cycle_time = 1000; 
  int currtime = esp_timer_get_time();
  leg_vals leg = legTraj((currtime-lasttime)/cycle_time);
  servoRR_BP.write(50);
  servoRR_BT.write(90);
  servoRR_BP.write(100);
  lasttime = currtime;
}

leg_vals legTraj(int time){
  // this function evaluates the trajectory we determine for the leg tip and returns a struct of the joint values needed to reach this point. 

}