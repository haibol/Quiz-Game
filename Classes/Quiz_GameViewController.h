//
//  Quiz_GameViewController.h
//  Quiz Game
//
//  Created by Kevin Anderson
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Quiz_GameViewController : UIViewController {
	IBOutlet	UILabel		*theQuestion;
	IBOutlet	UILabel		*theScore;
	IBOutlet	UILabel		*theLives;
	IBOutlet	UIButton	*answerOne;
	IBOutlet	UIButton	*answerTwo;
	IBOutlet	UIButton	*answerThree;
	IBOutlet	UIButton	*answerFour;
	IBOutlet	UIButton	*buttonStart;
	NSInteger myScore;
	NSInteger myLives;
	NSInteger questionNumber;
	NSInteger rightAnswer;
	NSInteger time;
	NSArray *theQuiz;
	NSTimer *timer;
	BOOL questionLive;
	BOOL restartGame;
	//anims
	NSTimer *animateTimerIn,*animateTimerOut;
	NSTimer *bounceTimer;
	int growCount, growDir;
	CGFloat buttonScale;
}

@property (retain, nonatomic) UILabel	*theQuestion;
@property (retain, nonatomic) UILabel	*theScore;
@property (retain, nonatomic) UILabel	*theLives;
@property (retain, nonatomic) UIButton  *buttonStart;
@property (retain, nonatomic) UIButton	*answerOne;
@property (retain, nonatomic) UIButton	*answerTwo;
@property (retain, nonatomic) UIButton	*answerThree;
@property (retain, nonatomic) UIButton	*answerFour;
@property (retain, nonatomic) NSArray *theQuiz;
@property (retain, nonatomic) NSTimer *timer;


@property (nonatomic, retain) NSTimer *animateTimerIn,*animateTimerOut;
@property (nonatomic, retain) NSTimer *bounceTimer;


-(void) bounceButtons;
-(void) moveButtonsIn;
-(void) moveButtonsOut;

-(void)checkAnswer:(int)theAnswerValue;

-(IBAction)buttonOne;
-(IBAction)buttonTwo;
-(IBAction)buttonThree;
-(IBAction)buttonFour;



-(void)askQuestion;

-(void)updateScore;

-(void)loadQuiz;

-(void)countDown;

@end

