import { Body, Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { User } from './schemas/auth.schema';
import mongoose  from 'mongoose';
import { SignUpDto } from './dto/sign-up.dto';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';
import { LogInDto } from './dto/login.dto';

@Injectable()
export class AuthService {
    constructor(
        @InjectModel(User.name)
        private userModel: mongoose.Model<User>,
        private jwtService: JwtService
    ){}

    async signUp(signUpDto:SignUpDto):Promise<{token:string}>{
        const {name,email,password} = signUpDto;

        const hashedPassword = await bcrypt.hash(password,10);
        const user = await this.userModel.create({
            name,
            email,
            password:hashedPassword

            })
        const token = this.jwtService.sign({id:user._id});  

        return { token };
 
    }
    async logIn(@Body() loginDto:LogInDto):Promise<{token:string}>{
        const {email,password} = loginDto;
        const user = await this.userModel.findOne({email})
        if (!user){
            throw new UnauthorizedException('Invalid email or password');
        }

        const isPasswordMatched = await bcrypt.compare(password,user.password);
        if (!isPasswordMatched){
            throw new UnauthorizedException('Invalid email or password');
        }

        const token = this.jwtService.sign({id:user._id});  

        return { token };

    }


}
