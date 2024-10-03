import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpDto } from './dto/sign-up.dto';
import { LogInDto } from './dto/login.dto';

@Controller('auth')
export class AuthController {
    constructor(private authService:AuthService){}

@Post('/signup') 
async signUp(@Body() signupDto:SignUpDto):Promise<{token:string}>{
    return this.authService.signUp(signupDto);}

@Post('/login')
async logIn(@Body() loginDto:LogInDto):Promise<{token:string}>{
    return this.authService.logIn(loginDto);
}    


}
