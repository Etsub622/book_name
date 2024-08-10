/* eslint-disable prettier/prettier */
import { IsEmpty, IsEnum, IsNotEmpty, IsString } from "class-validator";
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
    @IsString()
    price: number;

    @IsNotEmpty()
    @IsEnum(Category,{message: 'please enter a valid category'})
    category: Category;

    @IsEmpty({message:"you can't pass userId "})
    user:User


}