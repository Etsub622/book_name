/* eslint-disable prettier/prettier */
import { ArrayNotEmpty, IsArray, IsEmpty, IsEnum, IsNotEmpty, IsNumber, IsString } from "class-validator";
import { Category } from "../schemas/book.schema";
import { User } from "src/auth/schemas/auth.schema";

export class CreateBookDto{
    @IsNotEmpty()
    @IsString()
    title: string;

    @IsNotEmpty()
    @IsString()
    description: string;

    @IsNotEmpty()
    @IsString()
    author: string;

    @IsNotEmpty()
    @IsArray()
    @ArrayNotEmpty()
    imageUrl: string;

    @IsNotEmpty()
    @IsNumber()
    price: number;

    @IsArray()
    @ArrayNotEmpty()
    @IsEnum(Category, { each: true, message: 'please enter a valid category' })
    category: Category[];

    // @IsEmpty({message:"you can't pass userId "})
    // user:User


}