/* eslint-disable prettier/prettier */
import { IsEmpty, IsEnum, IsNumber, IsOptional, IsString } from "class-validator";
import { Category } from "../schemas/book.schema";
import { User } from "src/auth/schemas/auth.schema";

export class UpdateBookDto {
    @IsOptional()
    @IsString()
    title: string;

    @IsOptional()
    @IsString()
    description: string;

    @IsOptional()
    @IsString()
    author: string;

    @IsOptional()
    @IsNumber()
    price: number;

    @IsOptional()
    @IsEnum(Category,{message: 'please enter a valid category'})
    category: Category[];


    // @IsEmpty({message:"you can't pass userId "})
    // user:User
}