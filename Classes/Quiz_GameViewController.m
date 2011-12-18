//
//  Quiz_GameViewController.m
//  Quiz Game
//
//  Created by Kevin Anderson
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Quiz_GameViewController.h"

@implementation Quiz_GameViewController
@synthesize theQuestion;
@synthesize theScore;
@synthesize theLives;
@synthesize buttonStart;
@synthesize answerOne;
@synthesize answerTwo;
@synthesize answerThree;
@synthesize answerFour;
@synthesize theQuiz;
@synthesize timer;


//anim stuff

-(void) bounceButtons {
	
	
	if (buttonScale >= 1.400000) {
		growDir = 0;
	} 
	if (buttonScale <= 0.800000) { 
		growDir = 1;
	}
	switch (growDir) {
		case 0:
			buttonScale = buttonScale - 0.1f;
			break;
		case 1:
			buttonScale = buttonScale + 0.1f;
			if (buttonScale == 1.00000) {
				[bounceTimer invalidate];
			}
			break;
	}
	
	CGAffineTransform transform = CGAffineTransformMakeScale(buttonScale, buttonScale);
	answerOne.transform = transform;
	answerTwo.transform = transform;
	answerThree.transform = transform;
	answerFour.transform = transform;
}

-(IBAction) buttonBounce {
	growDir = 1;
	buttonScale = 1.000000;
	bounceTimer = [NSTimer
				   scheduledTimerWithTimeInterval:0.02
				   target:self
				   selector:@selector(bounceButtons)
				   userInfo:nil
				   repeats:YES];
}


-(IBAction) buttonMoveOut {
	animateTimerOut = [NSTimer 
					scheduledTimerWithTimeInterval:0.02
					target:self
					selector:@selector(animateButtonsOut)
					userInfo:nil
					repeats:YES];
}

-(IBAction) buttonMoveIn {
	animateTimerIn = [NSTimer
					scheduledTimerWithTimeInterval:0.02
					target:self
					selector:@selector(animateButtonsIn)
					userInfo:nil
					repeats:YES];
}


-(void) moveButtonsIn {
	[UIView beginAnimations:@"BUTTONMOVINGIN" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animation:didFinish:context:)];
	[answerOne setCenter:CGPointMake(160, 210)];
	[answerTwo setCenter:CGPointMake(160, 260)];
	[answerThree setCenter:CGPointMake(160, 310)];
	[answerFour setCenter:CGPointMake(160, 360)];
	[UIView commitAnimations];
}

-(void) moveButtonsOut {
	[UIView beginAnimations:@"BUTTONMOVINGOUT" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animation:didFinish:context:)];
	[answerOne setCenter:CGPointMake(-300, 210)];
	[answerTwo setCenter:CGPointMake(640, 260)];
	[answerThree setCenter:CGPointMake(-300, 310)];
	[answerFour setCenter:CGPointMake(640, 360)];
	[UIView commitAnimations];	
}
/*
-(void) animateButtonsOut {
	CGRect frame1 = [answerOne frame];
	CGRect frame2 = [answerTwo frame];
	CGRect frame3 = [answerThree frame];
	CGRect frame4 = [answerFour frame];
	frame1.origin.x = frame1.origin.x-1;
	frame2.origin.x = frame2.origin.x+1;
	frame3.origin.x = frame1.origin.x-1;
	frame4.origin.x = frame2.origin.x+1;
	answerOne.frame = frame1;
	answerTwo.frame = frame2;
	answerThree.frame = frame3;	
	answerFour.frame = frame4;
	if (frame1.origin.x == -300.00000 ) {
		[animateTimerOut invalidate];
	}
}


-(void) animateButtonsIn {
	CGRect frame1 = [answerOne frame];
	CGRect frame2 = [answerTwo frame];
	CGRect frame3 = [answerThree frame];
	CGRect frame4 = [answerFour frame];
	frame1.origin.x = frame1.origin.x+1;
	frame2.origin.x = frame2.origin.x-1;
	frame3.origin.x = frame1.origin.x+1;
	frame4.origin.x = frame2.origin.x-1;
	answerOne.frame = frame1;
	answerTwo.frame = frame2;
	answerThree.frame = frame3;	
	answerFour.frame = frame4;
	if (frame1.origin.x == 20.00000) {
		[animateTimerIn invalidate];
		[self buttonBounce];
	}
}
*/

-(void)animation:(NSString *)inAnimationID
didFinish:(NSNumber *)inFinished
context:(void *)inContext 
{
	[self buttonBounce];
}


-(void)askQuestion
{
	// Unhide all the answer buttons.
//	[self buttonMoveIn];
	[self moveButtonsIn];
	[buttonStart setHidden:YES];
	[answerOne setHidden:NO];
	[answerTwo setHidden:NO];
	[answerThree setHidden:NO];
	[answerFour setHidden:NO];

	
	// Set the game to a "live" question (for timer purposes)
	questionLive = YES;
	
	// Set the time for the timer
	time = 30.0;
	
	// Go to the next question
	questionNumber = questionNumber + 1;
	
	//[self buttonBounce];
	
	// THIS IS REALLY TERRIBLE CODE!!!
	// We get the question from the questionNumber * the row that we look up in the array.
	// This is absolutely horrible, just a placeholder until the right way.
	// I cannot even begin to describe how wrong this solution is.
	NSInteger row = 0;
	if(questionNumber == 1)
	{
		row = questionNumber - 1;
	}
	else
	{
		row = ((questionNumber - 1) * 6);
	}
	
	// Set the question string, and set the buttons the the answers
	NSString *selected = [theQuiz objectAtIndex:row];
	NSString *activeQuestion = [[NSString alloc] initWithFormat:@"Question: %@", selected];
	[answerOne setTitle:[theQuiz objectAtIndex:row+1] forState:UIControlStateNormal];
	[answerTwo setTitle:[theQuiz objectAtIndex:row+2] forState:UIControlStateNormal];
	[answerThree setTitle:[theQuiz objectAtIndex:row+3] forState:UIControlStateNormal];
	[answerFour setTitle:[theQuiz objectAtIndex:row+4] forState:UIControlStateNormal];
	rightAnswer = [[theQuiz objectAtIndex:row+5] intValue];
	
	// Set theQuestion label to the active question
	theQuestion.textAlignment =  UITextAlignmentLeft;
	theQuestion.textColor = [UIColor blackColor];
	theQuestion.text = activeQuestion;
	
	// Start the timer for the countdown
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
	
	[selected release];
	[activeQuestion release];
}

-(void)updateScore
{
	// If the score is being updated, the question is not live
	questionLive = NO;
	
	[timer invalidate];
	
	
	// Hide the answers from the previous question
	[self moveButtonsOut];
	//[answerOne setHidden:YES];
	//[answerTwo setHidden:YES];
	//[answerThree setHidden:YES];
	//[answerFour setHidden:YES];
	NSString *scoreUpdate = [[NSString alloc] initWithFormat:@"Score: %d", myScore];
	theScore.text = scoreUpdate;
	[scoreUpdate release];
	
	// END THE GAME.
	NSInteger endOfQuiz = [theQuiz count];
	if((((questionNumber - 1) * 6) + 6) == endOfQuiz)
	{
		// Game is over.
		if(myScore > 0)
		{
			NSString *finishingStatement = [[NSString alloc] initWithFormat:@"That's game!\nYou scored %i!", myScore];
			theQuestion.text = finishingStatement;
			[finishingStatement release];
		}
		else
		{
			NSString *finishingStatement = [[NSString alloc] initWithFormat:@"That's game!\nYou scored %i.", myScore];
			theQuestion.text = finishingStatement;
			[finishingStatement release];
		}
		theLives.text = @"";
		
		// Make button 1 appear as a reset game button
		restartGame = YES;
		[answerOne setHidden:NO];
		[answerOne setTitle:@"Restart the game (broke)" forState:UIControlStateNormal];
		
	}
	else
	{
	// Give a short rest between questions
	time = 3.0;
	
	// Initialize the timer
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
	}
}


// Check for the answer (this is not written right, but it runs)
-(void)checkAnswer:(int)theAnswerValue
{
	if(rightAnswer == theAnswerValue)
	{
		theQuestion.textAlignment =  UITextAlignmentCenter;
		theQuestion.textColor = [UIColor greenColor];
		theQuestion.text = @"Correct!";
		myScore = myScore + 50;
	}
	else
	{
		theQuestion.textAlignment = UITextAlignmentCenter;
		theQuestion.textColor = [UIColor redColor];
		theQuestion.text = @"FAIL!";
		myScore = myScore - 50;
	}
	[self updateScore];
}


-(void)countDown
{
	// Question live counter
	if(questionLive==YES)
	{
		time = time - 1;
		theLives.text = [NSString stringWithFormat:@"Time remaining: %i!", time];
		
		if(time == 0)
		{
			// Loser!
			questionLive = NO;
			theQuestion.textAlignment =  UITextAlignmentCenter;
			theQuestion.textColor = [UIColor redColor];
			theQuestion.text = @"Sorry, you ran out of time!";
			myScore = myScore - 50;
			[timer invalidate];
			[self updateScore];
		}
	}
	// In-between Question counter
	else
	{
		time = time - 1;
		theLives.text = [NSString stringWithFormat:@"Next question in...%i!", time];
	
		if(time == 0)
		{
			[timer invalidate];
			theLives.text = @"";
			[self askQuestion];
		}
	}
	if(time < 0)
	{
		[timer invalidate];
	}
}


- (IBAction)buttonOne
{
	if(questionNumber == 0){

		// This means that we are at the startup-state
		// We need to make the other buttons visible, and start the game.
		[answerTwo setHidden:NO];
		[answerThree setHidden:NO];
		[answerFour setHidden:NO];
		[self askQuestion];
	}
	else
	{
		NSInteger theAnswerValue = 1;
		[self checkAnswer:(int)theAnswerValue];
		if(restartGame==YES)
		{
			// Create a restart game function.
		}
	}
}

- (IBAction)buttonTwo
{
	NSInteger theAnswerValue = 2;
	[self checkAnswer:(int)theAnswerValue];
}

- (IBAction)buttonThree
{
	NSInteger theAnswerValue = 3;
	[self checkAnswer:(int)theAnswerValue];
}

- (IBAction)buttonFour
{
	NSInteger theAnswerValue = 4;
	[self checkAnswer:(int)theAnswerValue];
}



@synthesize animateTimerIn,animateTimerOut,bounceTimer;









// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[self buttonMoveOut];
	questionLive = NO;
	restartGame = NO;
	theQuestion.textAlignment =  UITextAlignmentLeft;
	theQuestion.textColor = [UIColor blackColor];
	theQuestion.text = @"Welcome to Stef's Quick Science Quiz (changeme)!";
	theScore.text = @"Score:0";
	theLives.text = @"";
	questionNumber = 0;
	myScore = 0;
	myLives = 0;
	//[buttonStart setTitle:@"Start Quiz" forstate:UIControlStateNormal];
	//[answerOne setTitle:@"Let's Play!" forState:UIControlStateNormal];
	[answerOne setHidden:YES];
	[answerTwo setHidden:YES];
	[answerThree setHidden:YES];
	[answerFour setHidden:YES];
	[self loadQuiz];
}

-(void)loadQuiz
{
	// This is our forced-loaded array of quiz questions.
	// FORMAT IS IMPORTANT!!!!
	// 1: Question, 2 3 4 5: Answers 1-4 respectively, 6: The right answer
	// THIS IS A TERRIBLE WAY TO DO THIS. I will figure out how to do nested arrays to make this better.
	NSArray *quizArray = [[NSArray alloc] initWithObjects:
						  @"Which rays are most damaging to cells?",@"Infrared",@"Ultraviolet",@"X-rays",@"Radio Waves",@"2",
						  @"Wavelengs that are shorter than visible light are:", @"Dangerous and can be harmful", @"Harmless", @"Have a low frequency", @"Can be seen with our eyes", @"4",
						  @"What is the difference between a Theory and a Law?", @"A theory can be proven", @"A law can be proven", @"A law is based on ideas", @"Theories are based on opinions", @"2",
						  @"What is a Hypothesis?", @"A guess", @"A law", @"What you change in an experiment", @"A prediction of the outcome", @"4",
						  @"Convert 1500 milliliters to meters:", @"1500000", @"150", @"1.5", @".015", @"3",
						  @"What would be the appropriate measure to record the length of a car?", @"Centimeters", @"Kilometers", @"Millimeters", @"Meters", @"4",
						  @"Magnitudes on the Richter Scale increase by what increment?", @"2 times", @"5 times", @"50%", @"10 times", @"4",
						  nil];
	self.theQuiz = quizArray;
	[quizArray release];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[theQuestion release];
	[theScore release];
	[theLives release];
	[buttonStart release];
	[answerOne release];
	[answerTwo release];
	[answerThree release];
	[answerFour release];
	[theQuiz release];
	[timer release];
    [super dealloc];
}

@end
