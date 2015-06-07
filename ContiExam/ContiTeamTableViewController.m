//
//  ContiTeamTableViewController.m
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "ContiTeamTableViewController.h"
#import "MemberTableViewCell.h"

@interface ContiTeamTableViewController ()

@end

@implementation ContiTeamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Check if there is data saved for member names & images
    _memberNames = [[[NSUserDefaults standardUserDefaults] arrayForKey: MEMBER_NAMES_KEY] mutableCopy];
    _imageCounter = [[NSUserDefaults standardUserDefaults] integerForKey: IMAGE_COUNTER_KEY];
    
    if( !_memberNames )
    {
        NSLog( @"There are no names saved" );
        _memberNames = [[NSMutableArray alloc] initWithObjects: @"Richter Belmont", @"Maria Renard", @"Alucard Fahrenheit", nil];
        [[NSUserDefaults standardUserDefaults] setObject:_memberNames forKey: MEMBER_NAMES_KEY];
    }
    else
    {
        NSLog( @"[%ld] Names saved", [_memberNames count] );
    }
    
    if( !_imageCounter )
    {
        NSLog( @"There are no images saved" );
        _imageCounter = IMAGE_COUNTER_INIT_VALUE;
        NSMutableArray* defaultPhotos = [[NSMutableArray alloc] initWithObjects: @"richter.jpg", @"maria.jpg", @"alucard.jpg", nil];
        
        for( NSString* photoName in defaultPhotos )
        {
            UIImage* img = [UIImage imageNamed: photoName];
            NSString* imgName = [NSString stringWithFormat:@"%@%ld", IMAGE_PREFIX, _imageCounter];
            
            [self saveImage:img withImageName: imgName];
            _imageCounter ++;
        }
        
        [[NSUserDefaults standardUserDefaults] setInteger:_imageCounter forKey: IMAGE_COUNTER_KEY];
    }
    else
    {
        NSLog( @"[%ld] Images saved", _imageCounter );
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Load images
    _memberPhotos = [[NSMutableArray alloc] init];
    for( NSInteger i = IMAGE_COUNTER_INIT_VALUE; i < _imageCounter; i++ )
    {
        NSString* imgName = [NSString stringWithFormat:@"%@%ld", IMAGE_PREFIX, i];
        UIImage* img = [self loadImage: imgName];
        [_memberPhotos addObject: img];
    }
    
    _addUserVC = [self.storyboard instantiateViewControllerWithIdentifier: @"AddUserViewController"];
    _addUserVC.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_memberNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"memberTableCell";
    MemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long row = [indexPath row];
    
    cell.lblMemberName.text = _memberNames[row];
    cell.imgMemberPhoto.image = _memberPhotos[row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addUserPressed:(id)sender
{
    //NSLog( @"Is add user beig presented? ... [%d]", _addUserVC.view.hidden );
    
    if( self.presentedViewController != _addUserVC )
    {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        [_addUserVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        [self presentViewController:_addUserVC animated:NO completion:nil];
    }
}

#pragma mark - Image Utileries

-(void)saveImage:(UIImage*)image withImageName:(NSString*)imageName
{
    NSData *imageData = UIImageJPEGRepresentation( image, 1.0 ); // Convert image into .jpeg format.
    NSFileManager *fileManager = [NSFileManager defaultManager]; // Create instance of NSFileManager
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); // Create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", imageName]]; // Add our image to the path
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; // Finally save the path (image)
}

-(UIImage*)loadImage:(NSString*)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}

#pragma mark - AddUserControllerDelegate

-(void) addNewMemberWithName:(NSString *)name andImage:(UIImage *)image
{
    NSLog( @"New member name: %@", name );
    
    if( !name || [name length] == 0 || !image )
    {
        return;
    }
    
    // Add name to memory array
    [_memberNames addObject: name];
    
    // Add image to memory array
    [_memberPhotos addObject: image];
    // Save image
    NSString* imgName = [NSString stringWithFormat:@"%@%ld", IMAGE_PREFIX, _imageCounter];
    [self saveImage: image withImageName: imgName];
    _imageCounter ++;
    
    [_memberTbl reloadData];
    
    // Save data
    [[NSUserDefaults standardUserDefaults] setObject:_memberNames forKey: MEMBER_NAMES_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:_imageCounter forKey: IMAGE_COUNTER_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end