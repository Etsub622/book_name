import { IsEmail, IsNotEmpty, IsString, MinLength } from "class-validator";

export class LogInDto{

    @IsNotEmpty()
    @IsEmail({},{message:'Invalid email'})
    email: string;

    @IsNotEmpty()
    @IsString()
    @MinLength(6)
    password: string;
}